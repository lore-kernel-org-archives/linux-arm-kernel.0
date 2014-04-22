From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 21 Apr 2014 21:53:04 -0700
Subject: Tegra baseline test results for v3.15-rc1
Message-ID: <5355F5B0.6060703@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.15-rc1.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.15-rc1/20140413153108/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.14 (455c6fdbd219161bd09b1165f11699d6d73de11c)):
    text     data      bss    total  kernel
+330455  +103624    +6112  +440191  multi_v7_defconfig
+191148   +13528    +4472  +209148  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.14 (455c6fdbd219161bd09b1165f11699d6d73de11c))
     avail    rsrvd     high    freed                board              kconfig                  dtb
   -49720k   49720k        .      36k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
   -49500k   49500k        .      12k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
   -49700k   49700k        .      36k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
   -49480k   49480k        .      12k       tegra30-beaver      tegra_defconfig       tegra30-beaver


48 MiB of additional reserved memory?  Ouch.  I had to rub my eyes and doublecheck.  It's the CMA allocation.
