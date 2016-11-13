From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:23:55 +0100
Subject: [PATCH v2 12/19] ARM: dts: armada-370-xp: Remove skeleton.dtsi
In-Reply-To: <20161113212402.3060-1-gregory.clement@free-electrons.com>
References: <20161113212402.3060-1-gregory.clement@free-electrons.com>
Message-ID: <20161113212402.3060-13-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The skeleton.dtsi file was removed in ARM64 for different reasons as
explained in commit ("3ebee5a2e141 arm64: dts: kill skeleton.dtsi").

These also applies to ARM and it will also allow to get rid of the
following DTC warnings in the future:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 2 --
 arch/arm/boot/dts/armada-370.dtsi    | 4 +++-
 arch/arm/boot/dts/armada-xp.dtsi     | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index c83c52d80b5b..728b7aa5e6fd 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -50,8 +50,6 @@
  * 370 and Armada XP SoC.
  */
 
-/include/ "skeleton64.dtsi"
-
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
 / {
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 6b22c6d255c1..33d29d344caa 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -50,9 +50,11 @@
  */
 
 #include "armada-370-xp.dtsi"
-/include/ "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	model = "Marvell Armada 370 family SoC";
 	compatible = "marvell,armada370", "marvell,armada-370-xp";
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 611fbcb02ebb..736a0b94da2b 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -53,6 +53,9 @@
 #include "armada-370-xp.dtsi"
 
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
 	model = "Marvell Armada XP family SoC";
 	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
 
-- 
2.10.2
