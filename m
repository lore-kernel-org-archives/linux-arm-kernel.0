From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 4 Apr 2014 08:19:20 +0000
Subject: mach header files
Message-ID: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resent, hopefully without the automatic corporate signature appended this time...

Hi,

I am porting the kernel to a new device, for which I've created a new arch/arm/mach-... directory, and I also a clock driver that lives under driver/clk. Everything is all working fine, though I am now cleaning up the code and have a question about mach specific header files.

The clock driver is completely specific to this device, but needs to read from a system register (just for external boot mode pins) to determine some PLL settings. This register is in a block of system registers which are also used by the mach code in arch/arm/mach-...

Since the clock driver is specific to the mach, is there any point in specifying the address of this reg in the corresponding dtsi? The format and functionality described by this register would not be the same on any other device.

If I don't specify the address of the register in the dtsi, I think it would be best to have a common header file for all of the system registers. I've seen some drivers, e.g.  exynos-cpufreq.c, doing this by including files from mach-exynos/include/mach. Is that the right way to do this?

Thanks
Phil
