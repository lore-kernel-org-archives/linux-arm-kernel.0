From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 24 Nov 2014 14:49:58 -0700
Subject: Tegra baseline test results for v3.18-rc6
Message-ID: <5473A806.6020302@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.18-rc6.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.18-rc6/20141123160102/


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
(delta in bytes from test_v3.18-rc5 (fc14f9c1272f62c3e8d01300f52467c0d9af50f9)):
    text     data      bss    total  kernel
   +9544     +192        0    +9736  multi_v7_defconfig
    +468      -16        0     +452  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.18-rc5 (fc14f9c1272f62c3e8d01300f52467c0d9af50f9))
     avail    rsrvd     high    freed                board              kconfig                  dtb
       -8k       8k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
       -8k       8k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
       -8k       8k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
