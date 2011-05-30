From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 30 May 2011 13:53:20 +0530
Subject: [PATCH 0/3] SPEAr320: Add pwm support
In-Reply-To: <201105300945.43816.arnd@arndb.de>
References: <cover.1306739836.git.viresh.kumar@st.com>
	<201105300945.43816.arnd@arndb.de>
Message-ID: <4DE353F8.9040207@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2011 01:15 PM, Arnd Bergmann wrote:
> No objection to your patch, but I think we need to have
> a long-term plan for pwm:
> 
> arnd at wuerfel:~/linux-2.6$ git ls-files | grep pwm.c
> arch/arm/mach-exynos4/include/mach/pwm-clock.h
> arch/arm/mach-mxs/devices/platform-mxs-pwm.c
> arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
> arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
> arch/arm/mach-s5pc100/include/mach/pwm-clock.h
> arch/arm/mach-s5pv210/include/mach/pwm-clock.h
> arch/arm/mach-vt8500/pwm.c
> arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> arch/arm/plat-mxc/pwm.c
> arch/arm/plat-pxa/pwm.c
> arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
> arch/arm/plat-samsung/dev-pwm.c
> arch/arm/plat-samsung/pwm-clock.c
> arch/arm/plat-samsung/pwm.c
> arch/mips/jz4740/pwm.c
> arch/unicore32/kernel/pwm.c
> drivers/leds/leds-atmel-pwm.c
> drivers/leds/leds-pwm.c
> drivers/mfd/twl6030-pwm.c
> drivers/misc/ab8500-pwm.c
> drivers/misc/atmel_pwm.c
> drivers/misc/ep93xx_pwm.c
> 
> My rough feeling is that what this should look like is a new
> subsystem that exports a set of operations and has specific
> drivers, like:
> 
> drivers/pwm/Kconfig
> drivers/pwm/pwm_core.c
> drivers/pwm/pwm_pxa.c
> drivers/pwm/pwm_unicore.c
> drivers/pwm/pwm_st.c
> drivers/pwm/pwm_...
> 

Sascha sent a patchset for something similar earlier.
But don't know what happened to it.

-- 
viresh
