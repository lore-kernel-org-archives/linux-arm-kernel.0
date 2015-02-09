From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 9 Feb 2015 09:01:21 +0000 (UTC)
Subject: Tegra baseline test results for v3.19
Message-ID: <alpine.DEB.2.02.1502090859260.3767@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.19.
Logs and other details at:

    http://nvt.pwsan.com/pub/linux/testlogs/test_v3.19/20150208193134/


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
(delta in bytes from test_v3.19-rc7 (e36f014edff70fc02b3d3d79cead1d58f289332e)):
   text     data      bss    total  kernel
  +1014     -568        0     +446  multi_v7_defconfig
   +298     -632       -4     -338  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.19-rc7 (e36f014edff70fc02b3d3d79cead1d58f289332e))
    avail    rsrvd     high    freed                board              kconfig                  dtb
      24k     -24k        .      -8k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      24k     -24k        .      -8k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
      24k     -24k        .      -8k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
