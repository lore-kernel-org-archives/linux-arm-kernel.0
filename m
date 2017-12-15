From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 18:07:11 +0100
Subject: [PATCH v2] arm: kirkwood: dts: Use lower case for bindings notation
In-Reply-To: <20171215124653.30902-1-malat@debian.org>
References: <20171215124653.30902-1-malat@debian.org>
Message-ID: <20171215170711.8212-1-malat@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the DTS files using lower case to fix the following dtc warnings:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Fix the original template message since it was completely misleading for kirkwood subarch.

 arch/arm/boot/dts/kirkwood-linksys-viper.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-linksys-viper.dts b/arch/arm/boot/dts/kirkwood-linksys-viper.dts
index df7851820507..f21a50dd9869 100644
--- a/arch/arm/boot/dts/kirkwood-linksys-viper.dts
+++ b/arch/arm/boot/dts/kirkwood-linksys-viper.dts
@@ -157,7 +157,7 @@
 			reg = <0x80000 0x20000>;
 		};
 
-		partition at A0000 {
+		partition at a0000 {
 			label = "s_env";
 			reg = <0xA0000 0x20000>;
 		};
@@ -167,17 +167,17 @@
 			reg = <0x200000 0x2A0000>;
 		};
 
-		partition at 4A0000 {
+		partition at 4a0000 {
 			label = "rootfs";
 			reg = <0x4A0000 0x1760000>;
 		};
 
-		partition at 1C00000 {
+		partition at 1c00000 {
 			label = "alt_kernel";
 			reg = <0x1C00000 0x2A0000>;
 		};
 
-		partition at 1EA0000 {
+		partition at 1ea0000 {
 			label = "alt_rootfs";
 			reg = <0x1EA0000 0x1760000>;
 		};
@@ -187,7 +187,7 @@
 			reg = <0x3600000 0x4A00000>;
 		};
 
-		partition at C0000 {
+		partition at c0000 {
 			label = "unused";
 			reg = <0xC0000 0x140000>;
 		};
-- 
2.11.0
