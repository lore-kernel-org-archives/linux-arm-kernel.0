From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 11 May 2015 10:58:08 -0600
Subject: Tegra baseline test results for v4.1-rc3
Message-ID: <5550DFA0.4050001@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.1-rc3.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v4.1-rc3/20150510163102/


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
(delta in bytes from test_v4.1-rc2 (5ebe6afaf0057ac3eaeb98defd5456894b446d22)):
    text     data      bss    total  kernel
     -24        0     -256     -280  defconfig
  +27380    +2440     +960   +30780  multi_v7_defconfig
    -200        0     -128     -328  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.1-rc2 (5ebe6afaf0057ac3eaeb98defd5456894b446d22))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        .      qemu-vexpress64            defconfig           __internal
      -32k      32k        .      20k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -32k      32k        .      20k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
      -32k      32k        .      20k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
         .        .        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
      -32k      32k        .      20k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
