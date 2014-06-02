From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jun 2014 00:42:16 +0100
Subject: Exynos induced build error with recent arm-soc
Message-ID: <20140602234216.GD933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spotted with a randconfig today:

arch/arm/mach-exynos/built-in.o: In function `exynos_set_cpu_boot_addr':
pm_domains.c:(.text+0x19c): undefined reference to `sysram_ns_base_addr'
arch/arm/mach-exynos/built-in.o:(.data+0x94): undefined reference to `exynos_enter_aftr'

This should be fixed before the merge window...

The failing .config is:

http://www.arm.linux.org.uk/developer/build/file.php?lid=8598

and the resulting build log with errors:

http://www.arm.linux.org.uk/developer/build/result.php?type=log&cid=3001&lid=8600&format=build

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
