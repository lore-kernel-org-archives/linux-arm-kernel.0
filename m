From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue,  9 Apr 2013 00:41:27 +0200
Subject: [PATCH v2 1/3] ARM: Kirkwood: sort board entries by ASCII-code order
In-Reply-To: <1365460889-22965-1-git-send-email-simon.guinot@sequanux.org>
References: <1365460889-22965-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1365460889-22965-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sorts board entries in files Kconfig, Makefile and
kirkwood_defconfig by ASCII-code order.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 arch/arm/configs/kirkwood_defconfig |   50 +++---
 arch/arm/mach-kirkwood/Kconfig      |  314 ++++++++++++++++++-----------------
 arch/arm/mach-kirkwood/Makefile     |   40 ++---
 3 files changed, 203 insertions(+), 201 deletions(-)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 46d704a..0421d0f 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -10,47 +10,47 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_KIRKWOOD=y
+CONFIG_MACH_D2NET_V2=y
 CONFIG_MACH_DB88F6281_BP=y
+CONFIG_MACH_DOCKSTAR=y
+CONFIG_MACH_ESATA_SHEEVAPLUG=y
+CONFIG_MACH_GURUPLUG=y
+CONFIG_MACH_INETSPACE_V2=y
+CONFIG_MACH_MV88F6281GTW_GE=y
+CONFIG_MACH_NET2BIG_V2=y
+CONFIG_MACH_NET5BIG_V2=y
+CONFIG_MACH_NETSPACE_MAX_V2=y
+CONFIG_MACH_NETSPACE_V2=y
+CONFIG_MACH_OPENRD_BASE=y
+CONFIG_MACH_OPENRD_CLIENT=y
+CONFIG_MACH_OPENRD_ULTIMATE=y
 CONFIG_MACH_RD88F6192_NAS=y
 CONFIG_MACH_RD88F6281=y
-CONFIG_MACH_MV88F6281GTW_GE=y
 CONFIG_MACH_SHEEVAPLUG=y
-CONFIG_MACH_ESATA_SHEEVAPLUG=y
-CONFIG_MACH_GURUPLUG=y
-CONFIG_MACH_DREAMPLUG_DT=y
-CONFIG_MACH_ICONNECT_DT=y
+CONFIG_MACH_T5325=y
+CONFIG_MACH_TS219=y
+CONFIG_MACH_TS41X=y
 CONFIG_MACH_DLINK_KIRKWOOD_DT=y
-CONFIG_MACH_IB62X0_DT=y
-CONFIG_MACH_TS219_DT=y
 CONFIG_MACH_DOCKSTAR_DT=y
+CONFIG_MACH_DREAMPLUG_DT=y
 CONFIG_MACH_GOFLEXNET_DT=y
 CONFIG_MACH_GURUPLUG_DT=y
-CONFIG_MACH_LSXL_DT=y
+CONFIG_MACH_IB62X0_DT=y
+CONFIG_MACH_ICONNECT_DT=y
+CONFIG_MACH_INETSPACE_V2_DT=y
 CONFIG_MACH_IOMEGA_IX2_200_DT=y
 CONFIG_MACH_KM_KIRKWOOD_DT=y
-CONFIG_MACH_INETSPACE_V2_DT=y
+CONFIG_MACH_LSXL_DT=y
 CONFIG_MACH_MPLCEC4_DT=y
-CONFIG_MACH_NETSPACE_V2_DT=y
-CONFIG_MACH_NETSPACE_MAX_V2_DT=y
 CONFIG_MACH_NETSPACE_LITE_V2_DT=y
+CONFIG_MACH_NETSPACE_MAX_V2_DT=y
 CONFIG_MACH_NETSPACE_MINI_V2_DT=y
+CONFIG_MACH_NETSPACE_V2_DT=y
+CONFIG_MACH_NSA310_DT=y
 CONFIG_MACH_OPENBLOCKS_A6_DT=y
 CONFIG_MACH_READYNAS_DT=y
 CONFIG_MACH_TOPKICK_DT=y
-CONFIG_MACH_TS219=y
-CONFIG_MACH_TS41X=y
-CONFIG_MACH_DOCKSTAR=y
-CONFIG_MACH_OPENRD_BASE=y
-CONFIG_MACH_OPENRD_CLIENT=y
-CONFIG_MACH_OPENRD_ULTIMATE=y
-CONFIG_MACH_NETSPACE_V2=y
-CONFIG_MACH_INETSPACE_V2=y
-CONFIG_MACH_NETSPACE_MAX_V2=y
-CONFIG_MACH_D2NET_V2=y
-CONFIG_MACH_NET2BIG_V2=y
-CONFIG_MACH_NET5BIG_V2=y
-CONFIG_MACH_T5325=y
-CONFIG_MACH_NSA310_DT=y
+CONFIG_MACH_TS219_DT=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 3fd07eb..938395a 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -2,23 +2,41 @@ if ARCH_KIRKWOOD
 
 menu "Marvell Kirkwood Implementations"
 
+config MACH_D2NET_V2
+	bool "LaCie d2 Network v2 NAS Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie d2 Network v2 NAS.
+
 config MACH_DB88F6281_BP
 	bool "Marvell DB-88F6281-BP Development Board"
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DB-88F6281-BP Development Board.
 
-config MACH_RD88F6192_NAS
-	bool "Marvell RD-88F6192-NAS Reference Board"
+config MACH_DOCKSTAR
+	bool "Seagate FreeAgent DockStar"
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Marvell RD-88F6192-NAS Reference Board.
+	  Seagate FreeAgent DockStar.
 
-config MACH_RD88F6281
-	bool "Marvell RD-88F6281 Reference Board"
+config MACH_ESATA_SHEEVAPLUG
+	bool "Marvell eSATA SheevaPlug Reference Board"
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Marvell RD-88F6281 Reference Board.
+	  Marvell eSATA SheevaPlug Reference Board.
+
+config MACH_GURUPLUG
+	bool "Marvell GuruPlug Reference Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell GuruPlug Reference Board.
+
+config MACH_INETSPACE_V2
+	bool "LaCie Internet Space v2 NAS Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie Internet Space v2 NAS.
 
 config MACH_MV88F6281GTW_GE
 	bool "Marvell 88F6281 GTW GE Board"
@@ -26,23 +44,93 @@ config MACH_MV88F6281GTW_GE
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell 88F6281 GTW GE Board.
 
+config MACH_NET2BIG_V2
+	bool "LaCie 2Big Network v2 NAS Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie 2Big Network v2 NAS.
+
+config MACH_NET5BIG_V2
+	bool "LaCie 5Big Network v2 NAS Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie 5Big Network v2 NAS.
+
+config MACH_NETSPACE_MAX_V2
+	bool "LaCie Network Space Max v2 NAS Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie Network Space Max v2 NAS.
+
+config MACH_NETSPACE_V2
+	bool "LaCie Network Space v2 NAS Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie Network Space v2 NAS.
+
+config MACH_OPENRD
+        bool
+
+config MACH_OPENRD_BASE
+	bool "Marvell OpenRD Base Board"
+	select MACH_OPENRD
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell OpenRD Base Board.
+
+config MACH_OPENRD_CLIENT
+	bool "Marvell OpenRD Client Board"
+	select MACH_OPENRD
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell OpenRD Client Board.
+
+config MACH_OPENRD_ULTIMATE
+	bool "Marvell OpenRD Ultimate Board"
+	select MACH_OPENRD
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell OpenRD Ultimate Board.
+
+config MACH_RD88F6192_NAS
+	bool "Marvell RD-88F6192-NAS Reference Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell RD-88F6192-NAS Reference Board.
+
+config MACH_RD88F6281
+	bool "Marvell RD-88F6281 Reference Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell RD-88F6281 Reference Board.
+
 config MACH_SHEEVAPLUG
 	bool "Marvell SheevaPlug Reference Board"
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell SheevaPlug Reference Board.
 
-config MACH_ESATA_SHEEVAPLUG
-	bool "Marvell eSATA SheevaPlug Reference Board"
+config MACH_T5325
+	bool "HP t5325 Thin Client"
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Marvell eSATA SheevaPlug Reference Board.
+	  HP t5325 Thin Client.
 
-config MACH_GURUPLUG
-	bool "Marvell GuruPlug Reference Board"
+config MACH_TS219
+	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Marvell GuruPlug Reference Board.
+	  QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
+	  TS-219P+ Turbo NAS devices.
+
+config MACH_TS41X
+	bool "QNAP TS-410, TS-410U, TS-419P, TS-419P+ and TS-419U Turbo NAS"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  QNAP TS-410, TS-410U, TS-419P, TS-419P+ and TS-419U Turbo
+	  NAS devices.
+
+comment "Device tree entries"
 
 config ARCH_KIRKWOOD_DT
 	bool "Marvell Kirkwood Flattened Device Tree"
@@ -58,12 +146,20 @@ config ARCH_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
 
-config MACH_GURUPLUG_DT
-	bool "Marvell GuruPlug Reference Board (Flattened Device Tree)"
+config MACH_DLINK_KIRKWOOD_DT
+	bool "D-Link Kirkwood-based NAS (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Marvell GuruPlug Reference Board (Flattened Device Tree).
+	  Kirkwood-based D-Link NASes such as DNS-320 & DNS-325,
+	  using Flattened Device Tree.
+
+config MACH_DOCKSTAR_DT
+	bool "Seagate FreeAgent Dockstar (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Seagate FreeAgent Dockstar (Flattened Device Tree).
 
 config MACH_DREAMPLUG_DT
 	bool "Marvell DreamPlug (Flattened Device Tree)"
@@ -72,19 +168,19 @@ config MACH_DREAMPLUG_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DreamPlug (Flattened Device Tree).
 
-config MACH_ICONNECT_DT
-	bool "Iomega Iconnect (Flattened Device Tree)"
+config MACH_GOFLEXNET_DT
+	bool "Seagate GoFlex Net (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
 	help
-	  Say 'Y' here to enable Iomega Iconnect support.
+	  Say 'Y' here if you want your kernel to support the
+	  Seagate GoFlex Net (Flattened Device Tree).
 
-config MACH_DLINK_KIRKWOOD_DT
-	bool "D-Link Kirkwood-based NAS (Flattened Device Tree)"
+config MACH_GURUPLUG_DT
+	bool "Marvell GuruPlug Reference Board (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Kirkwood-based D-Link NASes such as DNS-320 & DNS-325,
-	  using Flattened Device Tree.
+	  Marvell GuruPlug Reference Board (Flattened Device Tree).
 
 config MACH_IB62X0_DT
 	bool "RaidSonic IB-NAS6210, IB-NAS6220 (Flattened Device Tree)"
@@ -94,41 +190,18 @@ config MACH_IB62X0_DT
 	  RaidSonic IB-NAS6210 & IB-NAS6220 devices, using
 	  Flattened Device Tree.
 
-config MACH_TS219_DT
-	bool "Device Tree for QNAP TS-11X, TS-21X NAS"
-	select ARCH_KIRKWOOD_DT
-	select ARM_APPENDED_DTB
-	select ARM_ATAG_DTB_COMPAT
-	help
-	  Say 'Y' here if you want your kernel to support the QNAP
-	  TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
-	  TS-219P+ Turbo NAS devices using Fattened Device Tree.
-	  There are two different Device Tree descriptions, depending
-	  on if the device is based on an if the board uses the MV6281
-	  or MV6282. If you have the wrong one, the buttons will not
-	  work.
-
-config MACH_DOCKSTAR_DT
-	bool "Seagate FreeAgent Dockstar (Flattened Device Tree)"
-	select ARCH_KIRKWOOD_DT
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Seagate FreeAgent Dockstar (Flattened Device Tree).
-
-config MACH_GOFLEXNET_DT
-	bool "Seagate GoFlex Net (Flattened Device Tree)"
+config MACH_ICONNECT_DT
+	bool "Iomega Iconnect (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
 	help
-	  Say 'Y' here if you want your kernel to support the
-	  Seagate GoFlex Net (Flattened Device Tree).
+	  Say 'Y' here to enable Iomega Iconnect support.
 
-config MACH_LSXL_DT
-	bool "Buffalo Linkstation LS-XHL, LS-CHLv2 (Flattened Device Tree)"
+config MACH_INETSPACE_V2_DT
+	bool "LaCie Internet Space v2 NAS (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
 	help
-	  Say 'Y' here if you want your kernel to support the
-	  Buffalo Linkstation LS-XHL & LS-CHLv2 devices, using
-	  Flattened Device Tree.
+	  Say 'Y' here if you want your kernel to support the LaCie
+	  Internet Space v2 NAS, using Flattened Device Tree.
 
 config MACH_IOMEGA_IX2_200_DT
 	bool "Iomega StorCenter ix2-200 (Flattened Device Tree)"
@@ -144,12 +217,13 @@ config MACH_KM_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Keymile Kirkwood Reference Desgin, using Flattened Device Tree.
 
-config MACH_INETSPACE_V2_DT
-	bool "LaCie Internet Space v2 NAS (Flattened Device Tree)"
+config MACH_LSXL_DT
+	bool "Buffalo Linkstation LS-XHL, LS-CHLv2 (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
 	help
-	  Say 'Y' here if you want your kernel to support the LaCie
-	  Internet Space v2 NAS, using Flattened Device Tree.
+	  Say 'Y' here if you want your kernel to support the
+	  Buffalo Linkstation LS-XHL & LS-CHLv2 devices, using
+	  Flattened Device Tree.
 
 config MACH_MPLCEC4_DT
 	bool "MPL CEC4 (Flattened Device Tree)"
@@ -158,12 +232,12 @@ config MACH_MPLCEC4_DT
 	  Say 'Y' here if you want your kernel to support the
 	  MPL CEC4 (Flattened Device Tree).
 
-config MACH_NETSPACE_V2_DT
-	bool "LaCie Network Space v2 NAS (Flattened Device Tree)"
+config MACH_NETSPACE_LITE_V2_DT
+	bool "LaCie Network Space Lite v2 NAS (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
 	help
 	  Say 'Y' here if you want your kernel to support the LaCie
-	  Network Space v2 NAS, using Flattened Device Tree.
+	  Network Space Lite v2 NAS, using Flattened Device Tree.
 
 config MACH_NETSPACE_MAX_V2_DT
 	bool "LaCie Network Space Max v2 NAS (Flattened Device Tree)"
@@ -172,13 +246,6 @@ config MACH_NETSPACE_MAX_V2_DT
 	  Say 'Y' here if you want your kernel to support the LaCie
 	  Network Space Max v2 NAS, using Flattened Device Tree.
 
-config MACH_NETSPACE_LITE_V2_DT
-	bool "LaCie Network Space Lite v2 NAS (Flattened Device Tree)"
-	select ARCH_KIRKWOOD_DT
-	help
-	  Say 'Y' here if you want your kernel to support the LaCie
-	  Network Space Lite v2 NAS, using Flattened Device Tree.
-
 config MACH_NETSPACE_MINI_V2_DT
 	bool "LaCie Network Space Mini v2 NAS (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
@@ -187,6 +254,21 @@ config MACH_NETSPACE_MINI_V2_DT
 	  Network Space Mini v2 NAS (aka SafeBox), using Flattened
 	  Device Tree.
 
+config MACH_NETSPACE_V2_DT
+	bool "LaCie Network Space v2 NAS (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the LaCie
+	  Network Space v2 NAS, using Flattened Device Tree.
+
+config MACH_NSA310_DT
+	bool "ZyXEL NSA-310 (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	select ARM_ATAG_DTB_COMPAT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  ZyXEL NSA-310 board (Flattened Device Tree).
+
 config MACH_OPENBLOCKS_A6_DT
 	bool "Plat'Home OpenBlocks A6 (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
@@ -210,99 +292,19 @@ config MACH_TOPKICK_DT
 	  Say 'Y' here if you want your kernel to support the
 	  USI Topkick, using Flattened Device Tree
 
-config MACH_TS219
-	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
-	  TS-219P+ Turbo NAS devices.
-
-config MACH_TS41X
-	bool "QNAP TS-410, TS-410U, TS-419P, TS-419P+ and TS-419U Turbo NAS"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  QNAP TS-410, TS-410U, TS-419P, TS-419P+ and TS-419U Turbo
-	  NAS devices.
-
-config MACH_DOCKSTAR
-	bool "Seagate FreeAgent DockStar"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Seagate FreeAgent DockStar.
-
-config MACH_OPENRD
-        bool
-
-config MACH_OPENRD_BASE
-	bool "Marvell OpenRD Base Board"
-	select MACH_OPENRD
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell OpenRD Base Board.
-
-config MACH_OPENRD_CLIENT
-	bool "Marvell OpenRD Client Board"
-	select MACH_OPENRD
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell OpenRD Client Board.
-
-config MACH_OPENRD_ULTIMATE
-	bool "Marvell OpenRD Ultimate Board"
-	select MACH_OPENRD
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell OpenRD Ultimate Board.
-
-config MACH_NETSPACE_V2
-	bool "LaCie Network Space v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie Network Space v2 NAS.
-
-config MACH_INETSPACE_V2
-	bool "LaCie Internet Space v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie Internet Space v2 NAS.
-
-config MACH_NETSPACE_MAX_V2
-	bool "LaCie Network Space Max v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie Network Space Max v2 NAS.
-
-config MACH_D2NET_V2
-	bool "LaCie d2 Network v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie d2 Network v2 NAS.
-
-config MACH_NET2BIG_V2
-	bool "LaCie 2Big Network v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie 2Big Network v2 NAS.
-
-config MACH_NET5BIG_V2
-	bool "LaCie 5Big Network v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie 5Big Network v2 NAS.
-
-config MACH_T5325
-	bool "HP t5325 Thin Client"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  HP t5325 Thin Client.
-
-config MACH_NSA310_DT
-	bool "ZyXEL NSA-310 (Flattened Device Tree)"
+config MACH_TS219_DT
+	bool "Device Tree for QNAP TS-11X, TS-21X NAS"
 	select ARCH_KIRKWOOD_DT
+	select ARM_APPENDED_DTB
 	select ARM_ATAG_DTB_COMPAT
 	help
-	  Say 'Y' here if you want your kernel to support the
-	  ZyXEL NSA-310 board (Flattened Device Tree).
+	  Say 'Y' here if you want your kernel to support the QNAP
+	  TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
+	  TS-219P+ Turbo NAS devices using Fattened Device Tree.
+	  There are two different Device Tree descriptions, depending
+	  on if the device is based on an if the board uses the MV6281
+	  or MV6282. If you have the wrong one, the buttons will not
+	  work.
 
 endmenu
 
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index ff0f3cb..5f1285d 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,43 +1,43 @@
 obj-y				+= common.o addr-map.o irq.o pcie.o mpp.o
 
+obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_DB88F6281_BP)		+= db88f6281-bp-setup.o
-obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
-obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
-obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
-obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
+obj-$(CONFIG_MACH_DOCKSTAR)		+= dockstar-setup.o
 obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_GURUPLUG)		+= guruplug-setup.o
-obj-$(CONFIG_MACH_DOCKSTAR)		+= dockstar-setup.o
-obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
-obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
-obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
-obj-$(CONFIG_MACH_NETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_INETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
-obj-$(CONFIG_MACH_NETSPACE_MAX_V2)	+= netspace_v2-setup.o lacie_v2-common.o
-obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
+obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
+obj-$(CONFIG_MACH_NETSPACE_MAX_V2)	+= netspace_v2-setup.o lacie_v2-common.o
+obj-$(CONFIG_MACH_NETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
+obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
+obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
+obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
+obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
+obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
+obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
-obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
-obj-$(CONFIG_MACH_GURUPLUG_DT)		+= board-guruplug.o
-obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
-obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
-obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
 obj-$(CONFIG_MACH_DOCKSTAR_DT)		+= board-dockstar.o
+obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
 obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
-obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
+obj-$(CONFIG_MACH_GURUPLUG_DT)		+= board-guruplug.o
+obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
+obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
+obj-$(CONFIG_MACH_INETSPACE_V2_DT)	+= board-ns2.o
 obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
 obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
-obj-$(CONFIG_MACH_INETSPACE_V2_DT)	+= board-ns2.o
+obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
 obj-$(CONFIG_MACH_MPLCEC4_DT)		+= board-mplcec4.o
-obj-$(CONFIG_MACH_NETSPACE_V2_DT)	+= board-ns2.o
-obj-$(CONFIG_MACH_NETSPACE_MAX_V2_DT)	+= board-ns2.o
 obj-$(CONFIG_MACH_NETSPACE_LITE_V2_DT)	+= board-ns2.o
+obj-$(CONFIG_MACH_NETSPACE_MAX_V2_DT)	+= board-ns2.o
 obj-$(CONFIG_MACH_NETSPACE_MINI_V2_DT)	+= board-ns2.o
+obj-$(CONFIG_MACH_NETSPACE_V2_DT)	+= board-ns2.o
 obj-$(CONFIG_MACH_NSA310_DT)		+= board-nsa310.o
 obj-$(CONFIG_MACH_OPENBLOCKS_A6_DT)	+= board-openblocks_a6.o
 obj-$(CONFIG_MACH_READYNAS_DT)		+= board-readynas.o
 obj-$(CONFIG_MACH_TOPKICK_DT)		+= board-usi_topkick.o
+obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
-- 
1.7.10.4
