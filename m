From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Jun 2013 19:27:44 -0300
Subject: [PATCHv2 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
In-Reply-To: <1371754675-12242-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1371754675-12242-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1371754675-12242-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CAOMZO5AbZVLH0rxP=iuumrDBxFe5XVGH9qK9PyUdxtucbOHzdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 3:57 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> The ADCs connected to this bus have been experiencing some timeout
> issues when using the iMX28 i2c controller. Switching back to bitbanging
> solves this.

Could you please investigate this timeout issue?

The I2C timeouts I was having on mx28 when trying to access sgtl5000
codec, was due to the lack
of codec clock.

After I provided the codec clock I am able to use I2C without issues
and just sent a patch for it.
