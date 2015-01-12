From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 12 Jan 2015 15:09:09 -0700
Subject: Tegra baseline test results for v3.19-rc4
Message-ID: <54B44605.1010200@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.19-rc4.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.19-rc4/20150111130104/


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
(delta in bytes from test_v3.19-rc3 (b1940cd21c0f4abdce101253e860feff547291b0)):
    text     data      bss    total  kernel
    +880     +120        0    +1000  multi_v7_defconfig
    +448        0        0     +448  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.19-rc3 (b1940cd21c0f4abdce101253e860feff547291b0))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .      -4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .      -4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .      -4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
