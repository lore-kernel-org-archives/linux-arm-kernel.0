From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Feb 2013 11:45:30 +0100
Subject: Build error: OMAP randconfig / mvebu
In-Reply-To: <20130208100813.GN17833@n2100.arm.linux.org.uk>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk>
Message-ID: <2213733.Wbjy3dFgom@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 February 2013 10:08:13 Russell King - ARM Linux wrote:
> Last night's OMAP4430SDP randconfig build failed with:
> 
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_init_cpus':
> hotplug.c:(.init.text+0x70): undefined reference to `coherency_get_cpu_count'
> hotplug.c:(.init.text+0xb4): undefined reference to `armada_mpic_send_doorbell'
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_prepare_cpus':
> hotplug.c:(.init.text+0x254): undefined reference to `set_cpu_coherent'
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_boot_secondary':
> hotplug.c:(.cpuinit.text+0x10): undefined reference to `armada_xp_boot_cpu'
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_init':
> hotplug.c:(.cpuinit.text+0x2c): undefined reference to `armada_xp_mpic_smp_cpu_init'
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_startup':
> hotplug.c:(.cpuinit.text+0x40): undefined reference to `ll_set_cpu_coherent'
> 
> This seems to be because we ended up with CONFIG_ARCH_MVEBU=y but without
> CONFIG_MACH_ARMADA_370_XP being set - and because of OMAP, we have SMP
> and hotplug CPU enabled.
> 
> Usual configs/logs available via the website.

Ok, I see. I suspect we are going to see a lot more randconfig failures
now with all the platforms that are becoming part of multiplatform.

mvebu maintainers: this one should be easy enough to fix. Anyone
submitting a patch?

	Arnd
