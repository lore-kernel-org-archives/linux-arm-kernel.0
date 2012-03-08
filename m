From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Mar 2012 18:18:43 -0800
Subject: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators
 for v3.4
In-Reply-To: <877gywjhht.fsf@ti.com>
References: <877gywjhht.fsf@ti.com>
Message-ID: <20120308021843.GQ12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120307 11:42]:
> Tony,
> 
> Please pull the following support for using regulators to control the
> on-chip VC/VP managed voltage domains.
> 
> The regulator driver support for this is already queued in the regulator
> tree, and this is the supporting core work.
> 
> This combined with the CPUfreq changes to use the regulator framework
> will finally result in MPU DVFS working in mainline.

Nice.. However this one might be missing some header changes?

I'm getting the following:

arch/arm/mach-omap2/twl-common.c:174:15: error: variable 'omap3_vdd1_drvdata' has initializer but incomplete type
arch/arm/mach-omap2/twl-common.c:175:2: error: unknown field 'get_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:175:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:175:2: warning: (near initialization for 'omap3_vdd1_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c:176:2: error: unknown field 'set_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:176:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:176:2: warning: (near initialization for 'omap3_vdd1_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c:179:15: error: variable 'omap3_vdd2_drvdata' has initializer but incomplete type
arch/arm/mach-omap2/twl-common.c:180:2: error: unknown field 'get_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:180:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:180:2: warning: (near initialization for 'omap3_vdd2_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c:181:2: error: unknown field 'set_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:181:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:181:2: warning: (near initialization for 'omap3_vdd2_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c: In function 'omap3_pmic_get_config':
arch/arm/mach-omap2/twl-common.c:193:3: error: invalid use of undefined type 'struct twl_regulator_driver_data'
arch/arm/mach-omap2/twl-common.c:198:3: error: invalid use of undefined type 'struct twl_regulator_driver_data'
arch/arm/mach-omap2/twl-common.c: At top level:
arch/arm/mach-omap2/twl-common.c:400:15: error: variable 'omap4_vdd1_drvdata' has initializer but incomplete type
arch/arm/mach-omap2/twl-common.c:401:2: error: unknown field 'get_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:401:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:401:2: warning: (near initialization for 'omap4_vdd1_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c:402:2: error: unknown field 'set_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:402:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:402:2: warning: (near initialization for 'omap4_vdd1_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c:405:15: error: variable 'omap4_vdd2_drvdata' has initializer but incomplete type
arch/arm/mach-omap2/twl-common.c:406:2: error: unknown field 'get_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:406:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:406:2: warning: (near initialization for 'omap4_vdd2_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c:407:2: error: unknown field 'set_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:407:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:407:2: warning: (near initialization for 'omap4_vdd2_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c:410:15: error: variable 'omap4_vdd3_drvdata' has initializer but incomplete type
arch/arm/mach-omap2/twl-common.c:411:2: error: unknown field 'get_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:411:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:411:2: warning: (near initialization for 'omap4_vdd3_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c:412:2: error: unknown field 'set_voltage' specified in initializer
arch/arm/mach-omap2/twl-common.c:412:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-omap2/twl-common.c:412:2: warning: (near initialization for 'omap4_vdd3_drvdata') [enabled by default]
arch/arm/mach-omap2/twl-common.c: In function 'omap4_pmic_get_config':
arch/arm/mach-omap2/twl-common.c:425:3: error: invalid use of undefined type 'struct twl_regulator_driver_data'
arch/arm/mach-omap2/twl-common.c:431:3: error: invalid use of undefined type 'struct twl_regulator_driver_data'
arch/arm/mach-omap2/twl-common.c:435:16: error: 'struct twl4030_platform_data' has no member named 'vdd3'
arch/arm/mach-omap2/twl-common.c:437:3: error: invalid use of undefined type 'struct twl_regulator_driver_data'
arch/arm/mach-omap2/twl-common.c:438:12: error: 'struct twl4030_platform_data' has no member named 'vdd3'

Regards,

Tony
