From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 17 Sep 2014 01:24:50 +0000 (UTC)
Subject: Tegra baseline test results for v3.17-rc2
Message-ID: <alpine.DEB.2.02.1409170123190.5860@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.17-rc2.
Logs and other details at:

    http://nvt.pwsan.com/pub/linux/testlogs/test_v3.17-rc2/20140916145434/


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
(delta in bytes from test_v3.17-rc1 
(7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9)):
   text     data      bss    total  kernel
  +1592       +8        0    +1600  multi_v7_defconfig
  +1124       +8        0    +1132  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.17-rc1 
(7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
      -8k       8k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
      -8k       8k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      -8k       8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
