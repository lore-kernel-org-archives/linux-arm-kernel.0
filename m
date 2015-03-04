From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 4 Mar 2015 02:36:06 -0700
Subject: Tegra baseline test results for v4.0-rc2
Message-ID: <54F6D206.2070500@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.0-rc2.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v4.0-rc2/20150304011913/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
     Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
     Pass: ( 1/ 1): qemu-vexpress64

Boot to userspace: multi_v7_defconfig:
     Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539)):
    text     data      bss    total  kernel
+495197  +100104    +7232  +602533  multi_v7_defconfig
    +168        0        0     +168  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        .      qemu-vexpress64            defconfig           __internal
     -592k     592k        .      24k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
     -592k     592k        .      24k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
     -592k     592k        .      24k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver



An unusually large size increase from an -rc1 to an -rc2 release for multi_v7_defconfig.

Starting with this test report, an ARM64 defconfig kernel will be built and booted
on QEMU Versatile Express 64.
