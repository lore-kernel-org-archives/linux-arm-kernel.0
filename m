From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 1 Oct 2014 11:00:01 -0700
Subject: Tegra baseline test results for v3.17-rc5
Message-ID: <542C4121.9070109@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.17-rc5.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.17-rc5/20141001102438/


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
(delta in bytes from test_v3.17-rc4 (2ce7598c9a453e0acd0e07be7be3f5eb39608ebd)):
    text     data      bss    total  kernel
   +2036        0        0    +2036  multi_v7_defconfig
   +3108       -8        0    +3100  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.17-rc4 (2ce7598c9a453e0acd0e07be7be3f5eb39608ebd))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
       -8k       8k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
       -8k       8k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
       -8k       8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
