From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 20:19:35 +0200
Subject: [PATCH v2] pinctrl: shut up a couple of pinctrl warnings
In-Reply-To: <20130728121300.GF24642@n2100.arm.linux.org.uk>
References: <20130727103811.GD24642@n2100.arm.linux.org.uk>
 <20130728121300.GF24642@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdY2-6PAyELC0_vFpSV=N2PTN2JDG5Z-1w0-7LruCAo-Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 28, 2013 at 2:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> So, I notice that we get a couple of warnings from the pinctrl code:
>
> drivers/pinctrl/pinconf.c: In function 'pinconf_dbg_config_print':
> drivers/pinctrl/pinconf.c:433:36: warning: 'configs' may be used uninitialized in this function
> drivers/pinctrl/pinconf.c: In function 'pinconf_dbg_config_write':
> drivers/pinctrl/pinconf.c:511:36: warning: 'configs' may be used uninitialized in this function
>
> While the compiler might not be able to work out that "configs" is
> safe, the code doesn't lend itself very well to identifying that
> fact when reading it either.  This can be trivially solved by a slight
> restructuring of the code - which also reduces the LOC.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> So last nights build test found a silly in the last patch, so that's fixed
> in this version.

Thanks Russell, patch applied. Sorry for taking so long.

Yours,
Linus Walleij
