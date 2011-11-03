From: zonque@gmail.com (Daniel Mack)
Date: Thu, 03 Nov 2011 16:48:01 +0100
Subject: mainline tree fails to build with OMAP3-only config
Message-ID: <4EB2B7B1.4070804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

when trying to build an OMAP3-only config with Linus' current mainline 
HEAD, I'm getting the following errors. The same config works fine with 
v3.1.

The reasons seems to be that arch/arm/mach-omap2/io.c defines the 
*_init_early() functions unconditionally for all platforms. Is this 
already fixed in any tree?


Thanks,
Daniel


   LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `omap4430_init_early':
twl-common.c:(.init.text+0x4f0): undefined reference to 
`omap2_set_globals_443x'
twl-common.c:(.init.text+0x4f8): undefined reference to 
`omap44xx_voltagedomains_init'
twl-common.c:(.init.text+0x4fc): undefined reference to 
`omap44xx_powerdomains_init'
twl-common.c:(.init.text+0x500): undefined reference to 
`omap44xx_clockdomains_init'
twl-common.c:(.init.text+0x504): undefined reference to 
`omap44xx_hwmod_init'
twl-common.c:(.init.text+0x510): undefined reference to `omap4xxx_clk_init'
arch/arm/mach-omap2/built-in.o: In function `omap2430_init_early':
twl-common.c:(.init.text+0x578): undefined reference to 
`omap2_set_globals_243x'
twl-common.c:(.init.text+0x580): undefined reference to 
`omap2xxx_voltagedomains_init'
twl-common.c:(.init.text+0x584): undefined reference to 
`omap243x_powerdomains_init'
twl-common.c:(.init.text+0x588): undefined reference to 
`omap243x_clockdomains_init'
twl-common.c:(.init.text+0x58c): undefined reference to 
`omap2430_hwmod_init'
arch/arm/mach-omap2/built-in.o: In function `omap2420_init_early':
twl-common.c:(.init.text+0x59c): undefined reference to 
`omap2_set_globals_242x'
twl-common.c:(.init.text+0x5a4): undefined reference to 
`omap2xxx_voltagedomains_init'
twl-common.c:(.init.text+0x5a8): undefined reference to 
`omap242x_powerdomains_init'
twl-common.c:(.init.text+0x5ac): undefined reference to 
`omap242x_clockdomains_init'
twl-common.c:(.init.text+0x5b0): undefined reference to 
`omap2420_hwmod_init'
make: *** [.tmp_vmlinux1] Error 1
