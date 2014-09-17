From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 17 Sep 2014 01:22:44 +0000 (UTC)
Subject: Tegra baseline test results for v3.17-rc1
Message-ID: <alpine.DEB.2.02.1409170119520.5860@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.17-rc1.
Logs and other details at:

    http://nvt.pwsan.com/pub/linux/testlogs/test_v3.17-rc1/20140916142710/


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
(delta in bytes from test_v3.16 
(19583ca584d6f574384e17fe7613dfaeadcdc4a6)):
   text     data      bss    total  kernel
+447188   +63224    +1216  +511628  multi_v7_defconfig
+287957   +10172     +452  +298581  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.16 
(19583ca584d6f574384e17fe7613dfaeadcdc4a6))
    avail    rsrvd     high    freed                board              kconfig                  dtb
    -504k     504k        .      44k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
    -292k     292k        .       8k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
    -508k     508k        .      44k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
    -296k     296k        .       8k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
    -512k     512k        .      44k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
    -300k     300k        .       8k       tegra30-beaver      tegra_defconfig       tegra30-beaver
