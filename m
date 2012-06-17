From: olof@lixom.net (Olof Johansson)
Date: Sat, 16 Jun 2012 22:19:32 -0700
Subject: [PATCH] ARM: Kirkwood: Fix clk problems modular ethernet driver
In-Reply-To: <1339591965-4741-1-git-send-email-andrew@lunn.ch>
References: <1339591965-4741-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAOesGMix-2Mj_smw3t6oJFWNR-mXwXK3soPsne5U0xa7bu0pDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 13, 2012 at 5:52 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> When the ethernet driver was built as a module, it would lock the
> machine when loaded. At boot the ethernet clks are unused, so get
> turned off. ?Later, when the module is loaded, the probe function
> would access the hardware before the clock was restarted, and the
> machine would lock. It has also been determined that when the clk is
> turned off, the interface forgets its MAC address, which for most
> systems, is set by the boot loader.
>
> When the machine setup file creates a platform device for the
> interface, prepare and enable the clock for the interface. This will
> ensure it is not turned off. However, if the setup file only
> instantiates one platform device, the other will have its clk
> disabled, thus maybe saving a little power.
>
> Report-by: Simon Baatz <gmbnomis@gmail.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Simon Baatz <gmbnomis@gmail.com>

Thanks, applied to fixes.


-Olof
