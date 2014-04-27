From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Apr 2014 10:32:51 +0100
Subject: randconfig failures - MMC + trusted foundations
Message-ID: <20140427093250.GA26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last night's omap4430-sdp randconfig build:

In file included from arch/arm/mach-tegra/tegra.c:43:0:
arch/arm/include/asm/trusted_foundations.h: In function 'register_trusted_foundations':
arch/arm/include/asm/trusted_foundations.h:57:2: error: 'setup_max_cpus' undeclared (first use in this function)


Last night's versatile randconfig build:

drivers/mmc/core/core.c: In function 'mmc_card_power_up':
drivers/mmc/core/core.c:1517:4: error: implicit declaration of function 'gpiod_set_value'

This one appears to be a regular feature of failure, and is as I'm
carrying Olof's "mmc: add support for power-on sequencing through DT"
patch for CuBox wireless - see the 222 patch set.  It probably points
at something not being right with GPIO stuff.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
