From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  7 Nov 2016 22:41:27 +0100
Subject: [PATCH 2/3] arm64: dts: marvell: Fixup config-space DT warning For
 Armada 7K/8K
In-Reply-To: <20161107214128.18401-1-gregory.clement@free-electrons.com>
References: <20161107214128.18401-1-gregory.clement@free-electrons.com>
Message-ID: <20161107214128.18401-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

config-space has a ranges property so the unit name should contain an
address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 7b6136182ad0..a749ba2edec4 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -71,7 +71,7 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
-		config-space {
+		config-space at f0000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index e5e3ed678b6f..607e9a3ef834 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -52,7 +52,7 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
-		config-space {
+		config-space at f2000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 842fb333285c..88e74069c666 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -52,7 +52,7 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
-		config-space {
+		config-space at f4000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
-- 
2.10.1
