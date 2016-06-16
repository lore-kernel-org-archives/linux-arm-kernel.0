From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Jun 2016 14:28:35 +0200
Subject: [PATCH v4 3/4] arm64: dts: marvell: adjust to the latest mv-xor-v2 DT
 binding
In-Reply-To: <1466080116-26777-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1466080116-26777-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1466080116-26777-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Rob Herring, we should:

 1/ Use a SoC-specific compatible string in addition to the more generic
    one.

 2/ The generic compatible string has been changed from
    "marvell,mv-xor-v2" to "marvell,xor-v2".

We simply reflect the changes made to the Device Tree bindings to the
relevant Marvell 7K/8K Device Tree files.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 20d256b..eab1a42 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -141,7 +141,7 @@
 			};
 
 			xor at 400000 {
-				compatible = "marvell,mv-xor-v2";
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
 				reg = <0x400000 0x1000>,
 				      <0x410000 0x1000>;
 				msi-parent = <&gic_v2m0>;
@@ -149,7 +149,7 @@
 			};
 
 			xor at 420000 {
-				compatible = "marvell,mv-xor-v2";
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
 				reg = <0x420000 0x1000>,
 				      <0x430000 0x1000>;
 				msi-parent = <&gic_v2m0>;
@@ -157,7 +157,7 @@
 			};
 
 			xor at 440000 {
-				compatible = "marvell,mv-xor-v2";
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
 				reg = <0x440000 0x1000>,
 				      <0x450000 0x1000>;
 				msi-parent = <&gic_v2m0>;
@@ -165,7 +165,7 @@
 			};
 
 			xor at 460000 {
-				compatible = "marvell,mv-xor-v2";
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
 				reg = <0x460000 0x1000>,
 				      <0x470000 0x1000>;
 				msi-parent = <&gic_v2m0>;
-- 
2.7.4
