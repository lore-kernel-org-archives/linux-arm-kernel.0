From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 18 Nov 2014 03:00:31 +0000 (UTC)
Subject: Tegra baseline test results for v3.18-rc4
Message-ID: <alpine.DEB.2.02.1411180248240.3210@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.18-rc4.
Logs and other details at:

    http://nvt.pwsan.com/pub/linux/testlogs/test_v3.18-rc4/20141109150105/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
    Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.18-rc3 (0df1f2487d2f0d04703f142813d53615d62a1da4)):
   text     data      bss    total  kernel
 +37072   +30464      +64   +67600  multi_v7_defconfig
   +543      +16        0     +559  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.18-rc3 (0df1f2487d2f0d04703f142813d53615d62a1da4))
    avail    rsrvd     high    freed                board              kconfig                  dtb
     -68k      68k        .       4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
     -68k      68k        .       4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
     -68k      68k        .       4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver

Looking at the diffs for multi_v7_defconfig, I think the increase comes 
from some Qualcomm clock framework & pinctrl enablement patches.
