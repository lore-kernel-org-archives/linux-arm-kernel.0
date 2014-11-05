From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 5 Nov 2014 11:00:03 -0800
Subject: Tegra baseline test results for v3.18-rc3
Message-ID: <545A73B3.7030207@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.18-rc3.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.18-rc3/20141102153105/


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
(delta in bytes from test_v3.18-rc2 (cac7f2429872d3733dc3f9915857b1691da2eb2f)):
    text     data      bss    total  kernel
   -9231      -40      -64    -9335  multi_v7_defconfig
   -5463      -24        0    -5487  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.18-rc2 (cac7f2429872d3733dc3f9915857b1691da2eb2f))
     avail    rsrvd     high    freed                board              kconfig                  dtb
        8k      -8k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        8k      -8k        .      -4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        8k      -8k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        8k      -8k        .      -4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        8k      -8k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        8k      -8k        .      -4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
