From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Aug 2013 14:59:45 -0400
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.12
Message-ID: <20130814185945.GC13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This rather long branch adds the MBus devicetree binding and converts
everything over to using it.  It's been in -next over a week and should
be pretty stable.

Note:  There is a merge conflict with arm-soc/for-next, I've attached the
resolution after the summary.

thx,

Jason.


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/drivers-3.12

for you to fetch changes up to a0cec7867ffdf5d153d29b3a8243911ea8dfd366:

  memory: mvebu-devbus: Remove unused variable (2013-08-12 16:43:28 +0000)

----------------------------------------------------------------
mvebu drivers changes for v3.12

 - MBus devicetree bindings
 - devbus update for address decoding window, cleanup

----------------------------------------------------------------
Ezequiel Garcia (22):
      memory: mvebu-devbus: Remove address decoding window workaround
      bus: mvebu-mbus: Factor out initialization details
      bus: mvebu-mbus: Introduce device tree binding
      bus: mvebu-mbus: Add static window allocation to the DT binding
      bus: mvebu-mbus: Add new API for the PCIe memory and IO aperture
      PCI: mvebu: Check valid base address before port setup
      ARM: mvebu: Remove the harcoded BootROM window allocation
      ARM: mvebu: Initialize MBus using the DT binding
      ARM: mvebu: Use the preprocessor on Armada 370/XP device tree files
      ARM: mvebu: Add MBus to Armada 370/XP device tree
      ARM: mvebu: Add BootROM to Armada 370/XP device tree
      ARM: mvebu: Relocate Armada 370/XP DeviceBus device tree nodes
      ARM: mvebu: Relocate Armada 370/XP PCIe device tree nodes
      ARM: kirkwood: Split DT and legacy MBus initialization
      ARM: kirkwood: Use the preprocessor on device tree files
      ARM: kirkwood: Introduce MBus DT node
      ARM: kirkwood: Introduce MBUS_ID
      ARM: kirkwood: Relocate PCIe device tree nodes
      bus: mvebu-mbus: Add devicetree binding
      ARM: mvebu: Fix AXP-WiFi-AP DT for MBUS DT binding
      ARM: mvebu: Relocate PCIe node in Armada 370 RD board
      memory: mvebu-devbus: Remove unused variable

Jason Cooper (1):
      ARM: mvebu: use dts pre-processor for mv78230

Thomas Petazzoni (12):
      bus: mvebu-mbus: Add new API for window creation
      ARM: kirkwood: Move to ID based MBus window creation
      ARM: mv78xx0: Move to ID based window creation
      ARM: orion5x: Move to ID based window creation
      ARM: dove: Move to ID based window creation
      PCI: mvebu: Adapt to the new device tree layout
      bus: mvebu-mbus: Remove the no longer used name-based API
      bus: mvebu-mbus: Remove name -> target, attribute mapping tables
      bus: mvebu-mbus: Update main description
      bus: mvebu-mbus: Factorize Armada 370/XP data structures
      PCI: mvebu: Adapt to the new device tree layout
      ARM: mvebu: add support for the AXP WiFi AP board

 .../devicetree/bindings/bus/mvebu-mbus.txt         | 276 +++++++++++++
 .../devicetree/bindings/pci/mvebu-pci.txt          | 145 +++++--
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-370-db.dts                |   5 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  37 +-
 arch/arm/boot/dts/armada-370-rd.dts                |  37 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               | 111 +++---
 arch/arm/boot/dts/armada-370.dtsi                  | 112 +++---
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          | 164 ++++++++
 arch/arm/boot/dts/armada-xp-db.dts                 | 131 +++---
 arch/arm/boot/dts/armada-xp-gp.dts                 | 107 +++--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 224 ++++++-----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 263 ++++++------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 411 ++++++++++---------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  88 ++--
 arch/arm/boot/dts/armada-xp.dtsi                   |   9 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi               |  66 +--
 arch/arm/boot/dts/kirkwood-6282.dtsi               | 102 ++---
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |   4 +-
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |   7 +-
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |   7 +-
 arch/arm/boot/dts/kirkwood-db.dtsi                 |  10 +-
 arch/arm/boot/dts/kirkwood-dns320.dts              |   2 +-
 arch/arm/boot/dts/kirkwood-dns325.dts              |   2 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   4 +-
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   4 +-
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   4 +-
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |   4 +-
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |   4 +-
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   4 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  23 +-
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |   4 +-
 arch/arm/boot/dts/kirkwood-is2.dts                 |   2 +-
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   4 +-
 arch/arm/boot/dts/kirkwood-lschlv2.dts             |   2 +-
 arch/arm/boot/dts/kirkwood-lsxhl.dts               |   2 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |   4 +-
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  23 +-
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  23 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   4 +-
 arch/arm/boot/dts/kirkwood-ns2.dts                 |   2 +-
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |   2 +-
 arch/arm/boot/dts/kirkwood-ns2max.dts              |   2 +-
 arch/arm/boot/dts/kirkwood-ns2mini.dts             |   2 +-
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  23 +-
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |   4 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |   4 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |   2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |   2 +-
 arch/arm/boot/dts/kirkwood-topkick.dts             |   4 +-
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   6 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  25 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |  17 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |  17 +-
 arch/arm/mach-dove/common.c                        |  68 ++--
 arch/arm/mach-kirkwood/board-dt.c                  |   1 +
 arch/arm/mach-kirkwood/common.c                    |  26 +-
 arch/arm/mach-kirkwood/pcie.c                      |  40 +-
 arch/arm/mach-mv78xx0/pcie.c                       |  23 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  34 +-
 arch/arm/mach-mvebu/platsmp.c                      |  25 +-
 arch/arm/mach-orion5x/common.c                     |  36 +-
 arch/arm/mach-orion5x/common.h                     |  17 +
 arch/arm/mach-orion5x/d2net-setup.c                |   6 +-
 arch/arm/mach-orion5x/db88f5281-setup.c            |  24 +-
 arch/arm/mach-orion5x/dns323-setup.c               |   6 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c            |   6 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |  12 +-
 arch/arm/mach-orion5x/ls-chl-setup.c               |   6 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c               |   6 +-
 arch/arm/mach-orion5x/lsmini-setup.c               |   6 +-
 arch/arm/mach-orion5x/mss2-setup.c                 |   6 +-
 arch/arm/mach-orion5x/mv2120-setup.c               |   6 +-
 arch/arm/mach-orion5x/net2big-setup.c              |   6 +-
 arch/arm/mach-orion5x/pci.c                        |   9 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |   6 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |   6 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c            |  13 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c     |   6 +-
 arch/arm/mach-orion5x/ts209-setup.c                |   6 +-
 arch/arm/mach-orion5x/ts409-setup.c                |   6 +-
 arch/arm/mach-orion5x/wnr854t-setup.c              |   6 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |   6 +-
 drivers/bus/mvebu-mbus.c                           | 441 ++++++++++++---------
 drivers/memory/mvebu-devbus.c                      |  72 +---
 drivers/pci/host/pci-mvebu.c                       | 115 ++++--
 include/linux/mbus.h                               |  16 +-
 87 files changed, 2212 insertions(+), 1404 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt
 create mode 100644 arch/arm/boot/dts/armada-xp-axpwifiap.dts

And the promised resolution with arm-soc/for-next:
------------>8------------------
commit 89602312c5755c87a5ca6ba8ef6b0fce9d510951
Merge: a0cec78 f23afe2
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Wed Aug 14 18:55:13 2013 +0000

    Merge remote-tracking branch 'arm-soc/for-next' into mvebu/drivers
    
    Conflicts:
    	arch/arm/boot/dts/kirkwood.dtsi

diff --cc arch/arm/boot/dts/kirkwood-db.dtsi
index 45c1bf7,ca8bf36..c0e2a58
--- a/arch/arm/boot/dts/kirkwood-db.dtsi
+++ b/arch/arm/boot/dts/kirkwood-db.dtsi
@@@ -77,5 -77,29 +77,21 @@@
  			cd-gpios = <&gpio1 6 0>;
  			status = "okay";
  		};
 -
 -		pcie-controller {
 -			status = "okay";
 -
 -			pcie at 1,0 {
 -				status = "okay";
 -			};
 -		};
  	};
  };
+ 
+ &mdio {
+ 	status = "okay";
+ 
+ 	ethphy0: ethernet-phy at 8 {
+ 		device_type = "ethernet-phy";
+ 		reg = <8>;
+ 	};
+ };
+ 
+ &eth0 {
+ 	status = "okay";
+ 	ethernet0-port at 0 {
+ 		phy-handle = <&ethphy0>;
+ 	};
+ };
diff --cc arch/arm/boot/dts/kirkwood-ts219.dtsi
index 7019cf6,102eaeb..39158cf
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@@ -97,5 -87,28 +97,21 @@@
  			status = "okay";
  			nr-ports = <2>;
  		};
 -		pcie-controller {
 -			status = "okay";
 -
 -			pcie at 1,0 {
 -				status = "okay";
 -			};
 -		};
  	};
  };
+ 
+ &mdio {
+ 	status = "okay";
+ 
+ 	ethphy0: ethernet-phy {
+ 		device_type = "ethernet-phy";
+                 /* overwrite reg property in board file */
+ 	};
+ };
+ 
+ &eth0 {
+ 	status = "okay";
+ 	ethernet0-port at 0 {
+ 		phy-handle = <&ethphy0>;
+ 	};
+ };
diff --cc arch/arm/boot/dts/kirkwood.dtsi
index 70f414d,1d6921d..6489b98
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@@ -22,23 -20,7 +22,16 @@@
  	       gpio0 = &gpio0;
  	       gpio1 = &gpio1;
  	};
- 	intc: interrupt-controller {
- 		compatible = "marvell,orion-intc", "marvell,intc";
- 		interrupt-controller;
- 		#interrupt-cells = <1>;
- 		reg = <0xf1020204 0x04>,
- 		      <0xf1020214 0x04>;
- 	};
  
 +	mbus {
 +		compatible = "marvell,kirkwood-mbus", "simple-bus";
 +		#address-cells = <2>;
 +		#size-cells = <1>;
 +		controller = <&mbusc>;
 +		pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256 MiB memory space */
 +		pcie-io-aperture  = <0xf2000000 0x100000>;   /*   1 MiB    I/O space */
 +	};
 +
  	ocp at f1000000 {
  		compatible = "simple-bus";
  		ranges = <0x00000000 0xf1000000 0x0100000
@@@ -47,11 -30,30 +40,35 @@@
  		#address-cells = <1>;
  		#size-cells = <1>;
  
+ 		timer: timer at 20300 {
+ 			compatible = "marvell,orion-timer";
+ 			reg = <0x20300 0x20>;
+ 			interrupt-parent = <&bridge_intc>;
+ 			interrupts = <1>, <2>;
+ 			clocks = <&core_clk 0>;
+ 		};
+ 
+ 		intc: main-interrupt-ctrl at 20200 {
+ 			compatible = "marvell,orion-intc";
+ 			interrupt-controller;
+ 			#interrupt-cells = <1>;
+ 			reg = <0x20200 0x10>, <0x20210 0x10>;
+ 		};
+ 
+ 		bridge_intc: bridge-interrupt-ctrl at 20110 {
+ 			compatible = "marvell,orion-bridge-intc";
+ 			interrupt-controller;
+ 			#interrupt-cells = <1>;
+ 			reg = <0x20110 0x8>;
+ 			interrupts = <1>;
+ 			marvell,#interrupts = <6>;
+ 		};
+ 
 +		mbusc: mbus-controller at 20000 {
 +			compatible = "marvell,mbus-controller";
 +			reg = <0x20000 0x80>, <0x1500 0x20>;
 +		};
 +
  		core_clk: core-clocks at 10030 {
  			compatible = "marvell,kirkwood-core-clock";
  			reg = <0x10030 0x4>;
diff --cc arch/arm/mach-orion5x/edmini_v2-setup.c
index 0fc33c5,7d316ed..f66c1b2
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@@ -152,12 -144,9 +144,11 @@@ void __init edmini_v2_init(void
  	 * Configure peripherals.
  	 */
  	orion5x_ehci0_init();
- 	orion5x_eth_init(&edmini_v2_eth_data);
  
 -	mvebu_mbus_add_window("devbus-boot", EDMINI_V2_NOR_BOOT_BASE,
 -			      EDMINI_V2_NOR_BOOT_SIZE);
 +	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
 +				    ORION_MBUS_DEVBUS_BOOT_ATTR,
 +				    EDMINI_V2_NOR_BOOT_BASE,
 +				    EDMINI_V2_NOR_BOOT_SIZE);
  	platform_device_register(&edmini_v2_nor_flash);
  
  	pr_notice("edmini_v2: USB device port, flash write and power-off "
