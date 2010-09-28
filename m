From: hemanthv@ti.com (Hemanth V)
Date: Tue, 28 Sep 2010 18:23:24 +0530
Subject: [PATCH 1/7] pwm: Add pwm core driver
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
	<1285670134-18063-2-git-send-email-arun.murthy@stericsson.com>
Message-ID: <040c01cb5f0c$29bcb3b0$LocalHost@wipblrx0099946>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Original Message ----- 
From: "Arun Murthy" <arun.murthy@stericsson.com>


> The existing pwm based led and backlight driver makes use of the
> pwm(include/linux/pwm.h). So all the board specific pwm drivers will
> be exposing the same set of function name as in include/linux/pwm.h.
> As a result build fails in case of multi soc environments where each soc
> has a pwm device in it.

This seems very specific to ST environment,  looking at the driver list from
( [PATCH 4/7] pwm: Align existing pwm drivers with pwm-core ) it seems
most multi SOC environments might support PWM in either one of the SOC.

arch/arm/plat-mxc/pwm.c
arch/arm/plat-pxa/pwm.c
arch/arm/plat-samsung/pwm.c
arch/mips/jz4740/pwm.c
drivers/mfd/twl6030-pwm.c

Unless people have examples of other SOCs which might use this,
the better approach might be to go for a custom driver rather than changing
the framework.

Thanks
Hemanth 
