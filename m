From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 8 Jan 2015 03:26:43 -0700
Subject: Tegra baseline test results for v3.19-rc2
Message-ID: <54AE5B63.9010407@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.19-rc2.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.19-rc2/20150108021603/


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
(delta in bytes from test_v3.19-rc1 (97bf6af1f928216fd6c5a66e8a57bfa95a659672)):
    text     data      bss    total  kernel
   +1240       +8        0    +1248  multi_v7_defconfig
    +752        0        0     +752  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.19-rc1 (97bf6af1f928216fd6c5a66e8a57bfa95a659672))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .      -4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .      -4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .      -4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
