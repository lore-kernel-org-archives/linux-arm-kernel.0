From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 18 May 2015 20:43:27 +0000 (UTC)
Subject: Tegra baseline test results for v4.1-rc4
Message-ID: <alpine.DEB.2.02.1505182041480.32204@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v4.1-rc4.
Logs and other details at:

    http://nvt.pwsan.com/pub/linux/testlogs/test_v4.1-rc4/20150518103104/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
    Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
    Pass: ( 1/ 1): qemu-vexpress64

Boot to userspace: multi_v7_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.1-rc3 (030bbdbf4c833bc69f502eae58498bc5572db736)):
   text     data      bss    total  kernel
  +4075    -3584        0     +491  defconfig
  +1671     +704        0    +2375  multi_v7_defconfig
  +1559     +256        0    +1815  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.1-rc3 (030bbdbf4c833bc69f502eae58498bc5572db736))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
      -4k       4k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
      -4k       4k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
      -4k       4k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      -4k       4k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
