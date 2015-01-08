From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 8 Jan 2015 03:18:46 -0700
Subject: Tegra baseline test results for v3.19-rc1
Message-ID: <54AE5986.6030806@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.19-rc1.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.19-rc1/20150108014100/


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
(delta in bytes from test_v3.18 (b2776bf7149bddd1f4161f14f79520f17fc1d71d)):
    text     data      bss    total  kernel
+882219   +15760    -2432  +895547  multi_v7_defconfig
+149737    +2872   -12344  +140265  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.18 (b2776bf7149bddd1f4161f14f79520f17fc1d71d))
     avail    rsrvd     high    freed                board              kconfig                  dtb
     -872k     872k        .      40k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
     -140k     140k        .      16k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
     -876k     876k        .      40k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
     -144k     144k        .      16k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
     -868k     868k        .      40k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
     -136k     136k        .      16k       tegra30-beaver      tegra_defconfig       tegra30-beaver


The kernel boot-time memory report line changed.  Now it breaks CMA-reserved memory out into a separate quantity.  It's been lumped back in with reserved memory in this report.
