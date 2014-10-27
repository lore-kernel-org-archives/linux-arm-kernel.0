From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 27 Oct 2014 11:55:41 -0700
Subject: Tegra baseline test results for v3.18-rc2
Message-ID: <544E952D.2020109@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.18-rc2.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.18-rc2/20141026170104/


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
(delta in bytes from test_v3.18-rc1 (f114040e3ea6e07372334ade75d1ee0775c355e1)):
    text     data      bss    total  kernel
  +12834     +368        0   +13202  multi_v7_defconfig
   +5283     +128        0    +5411  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.18-rc1 (f114040e3ea6e07372334ade75d1ee0775c355e1))
     avail    rsrvd     high    freed                board              kconfig                  dtb
      -16k      16k        .       4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
       -8k       8k        .       4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -16k      16k        .       4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
       -8k       8k        .       4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
      -16k      16k        .       4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
       -8k       8k        .       4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
