From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 30 Aug 2012 13:33:47 +0100
Subject: [PATCH] clk: convert ARM RealView to common clk
In-Reply-To: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
References: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1346330027.2623.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I'm working on moving the VE clocking into driver/clk on top of your
Realview change, and just spotted one minor issue...

On Mon, 2012-08-06 at 17:32 +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This converts the ARM RealView machine over to using the common
> clock. The approach is similar to the one used for the Integrator,
> and we're reusing the ICST wrapper code.
[...]
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 7f0b5ca..89b726d 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -40,4 +40,11 @@ config COMMON_CLK_WM831X
>            Supports the clocking subsystem of the WM831x/2x series of
>           PMICs from Wolfson Microlectronics.
> 
> +config COMMON_CLK_VERSATILE
> +       tristate "Clock driver for ARM Reference designs"

It can't really be a "tristate", can it? To my mind there is no way of
making it a module, so a "bool" seems more appropriate?

> +       depends on ARCH_INTEGRATOR || ARCH_REALVIEW
> +       ---help---
> +          Supports clocking on ARM Reference designs Integrator/AP,
> +         Integrator/CP, RealView PB1176, EB, PB11MP and PBX.
> +
>  endmenu

Cheers!

Pawe?
