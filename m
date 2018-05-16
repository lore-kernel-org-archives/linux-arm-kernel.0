From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Wed, 16 May 2018 17:51:57 +0800
Subject: [PATCH] arm64: dts: move berlin SoC files from marvell dir to
 synaptics dir
Message-ID: <20180516175157.3d02dbdc@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move device tree files as part of transition from Marvell berlin to
Synaptics berlin.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/boot/dts/Makefile                                 | 1 +
 arch/arm64/boot/dts/marvell/Makefile                         | 4 ----
 arch/arm64/boot/dts/synaptics/Makefile                       | 4 ++++
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-dmp.dts | 0
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-stb.dts | 0
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi    | 0
 6 files changed, 5 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/synaptics/Makefile
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-dmp.dts (100%)
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-stb.dts (100%)
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi (100%)

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 4aa50b9b26bc..3543bc324553 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -22,5 +22,6 @@ subdir-y += renesas
 subdir-y += rockchip
 subdir-y += socionext
 subdir-y += sprd
+subdir-y += synaptics
 subdir-y += xilinx
 subdir-y += zte
diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index cb454beede55..ea9d49f2a911 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# Berlin SoC Family
-dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-dmp.dtb
-dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
-
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
diff --git a/arch/arm64/boot/dts/synaptics/Makefile b/arch/arm64/boot/dts/synaptics/Makefile
new file mode 100644
index 000000000000..de71ddda6835
--- /dev/null
+++ b/arch/arm64/boot/dts/synaptics/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Berlin SoC Family
+dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-dmp.dtb
+dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts b/arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts
similarity index 100%
rename from arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
rename to arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts
similarity index 100%
rename from arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
rename to arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/marvell/berlin4ct.dtsi
rename to arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
-- 
2.17.0
