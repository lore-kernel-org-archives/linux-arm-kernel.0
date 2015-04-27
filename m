From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 27 Apr 2015 16:49:24 +0000 (UTC)
Subject: Tegra baseline test results for v4.1-rc1
Message-ID: <alpine.DEB.2.02.1504271642550.31868@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v4.1-rc1.
Logs and other details at:

    http://nvt.pwsan.com/pub/linux/testlogs/test_v4.1-rc1/20150426183104/


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
(delta in bytes from test_v4.0 (39a8804455fb23f09157341d3ba7db6d7ae6ee76)):
   text     data      bss    total  kernel
+330066   +29448    +1472  +360986  multi_v7_defconfig
+117544    +7768     +612  +125924  tegra_defconfig
+634958  +147392    +2840  +785190  defconfig


Boot-time memory difference
(delta in bytes from test_v4.0 (39a8804455fb23f09157341d3ba7db6d7ae6ee76))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
    -372k     372k        .      20k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
    -144k     144k        .      12k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
    -408k     408k        .      20k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
    -180k     180k        .      12k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
    -364k     364k        .      20k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
    -136k     136k        .      12k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
    -500k     500k        .      20k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
    -272k     272k        .      12k       tegra30-beaver      tegra_defconfig       tegra30-beaver
