From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Sun, 1 Mar 2015 19:15:40 -0700
Subject: Tegra baseline test results for v4.0-rc1
Message-ID: <54F3C7CC.9060501@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.0-rc1.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v4.0-rc1/20150227011322/


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
(delta in bytes from test_v3.19 (bfa76d49576599a4b9f9b7a71f23d73d6dcff735)):
    text     data      bss    total  kernel
+251708   -28136    +1408  +224980  multi_v7_defconfig
+117609   -26896     +720   +91433  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.19 (bfa76d49576599a4b9f9b7a71f23d73d6dcff735))
     avail    rsrvd     high    freed                board              kconfig                  dtb
     -256k     256k        .      16k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
     -104k     104k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
     -260k     260k        .      16k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
     -108k     108k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
     -256k     256k        .      16k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
     -104k     104k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
