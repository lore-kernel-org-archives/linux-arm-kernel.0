From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Sep 2017 09:36:29 +0100
Subject: [PATCH 1/7] i2c: gpio: Convert to use descriptors
In-Reply-To: <20170917093906.16325-2-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org>
Message-ID: <20170918083629.qn4dlrmk7ffipfsz@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 17 Sep 2017, Linus Walleij wrote:

> This converts the GPIO-based I2C-driver to using GPIO
> descriptors instead of the old global numberspace-based
> GPIO interface. We:

[STUFF]

> - The MFD Silicon Motion SM501 is a special case. It dynamically
>   spawns an I2C bus off the MFD using sm501_create_subdev().
>   We use an approach to dynamically create a machine descriptor
>   table and attach this to the "SM501-LOW" or "SM501-HIGH"
>   gpiochip. We use chip-local offsets to grab the right lines.
>   We can get rid of two local static inline helpers as part
>   of this refactoring.
> 
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ville Syrj?l? <ville.syrjala@linux.intel.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Heiko Schocher <hs@denx.de>
> Acked-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix a minor typo in error path (scl was sda from copy-paste)
> - Collected Olof's ACK
> 
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> Lee: requesting ACK for Wolfram to take this patch.

This ...

> SM501 users: requesting Tested-by on this patch.

... loosely depends on this (until it doesn't).

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
