From: khilman@ti.com (Kevin Hilman)
Date: Mon, 10 Oct 2011 11:41:05 -0700
Subject: [PATCH] ARM: omap2+: stub out omap*_volt_data
In-Reply-To: <1397689.kebELtC4N3@wuerfel> (Arnd Bergmann's message of "Sat, 08
	Oct 2011 17:23:24 +0200")
References: <1397689.kebELtC4N3@wuerfel>
Message-ID: <87ipnwhepq.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> When CONFIG_PM_OPP is not set, the definitions for these variables
> are not available, so we should conditionally define them to
> NULL.
>
> arch/arm/mach-omap2/built-in.o: In function `omap3xxx_voltagedomains_init':
> voltagedomains3xxx_data.c:100: undefined reference to `omap36xx_vddmpu_volt_data'
> voltagedomains3xxx_data.c:100: undefined reference to `omap34xx_vddmpu_volt_data'
> voltagedomains3xxx_data.c:100: undefined reference to `omap36xx_vddcore_volt_data'
> voltagedomains3xxx_data.c:100: undefined reference to `omap34xx_vddcore_volt_data'
> arch/arm/mach-omap2/built-in.o: In function `omap44xx_voltagedomains_init':
> voltagedomains44xx_data.c:111: undefined reference to `omap44xx_vdd_mpu_volt_data'
> voltagedomains44xx_data.c:111: undefined reference to `omap44xx_vdd_iva_volt_data'
> voltagedomains44xx_data.c:111: undefined reference to `omap44xx_vdd_core_volt_data'
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kevin Hilman <khilman@ti.com>

> ---
> I got this build error only now after pulling in the latest omap series, but
> I cannot tell what caused it. It's also not clear to me if this is the correct
> solution. Please ack or provide a better fix.

This code was merged for v2.6.39, so not sure why this error is only
showing up for you now.  I just tried a !CONFIG_PM_OPP build on v2.6.39
and get the same errors, so it's been lingering.

Maybe you haven't had a randconfig that disabled CONFIG_PM_OPP before?

Anyways, the fix is fine with me.

Kevin
