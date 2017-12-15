From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 20:19:30 +0100
Subject: [PATCH v3] arm: imx: dts: Use lower case for bindings notation
In-Reply-To: <20171215124631.30132-1-malat@debian.org>
References: <20171215124631.30132-1-malat@debian.org>
Message-ID: <20171215191930.11410-1-malat@debian.org>
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
v2: Remove invalid patch for imx7s.dtsi, remove duplicate patch for imx7d.dtsi
v3: Clarify the commit message

 arch/arm/boot/dts/imx6q-display5.dtsi | 2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
index 4084de43d4d9..09085fde3341 100644
--- a/arch/arm/boot/dts/imx6q-display5.dtsi
+++ b/arch/arm/boot/dts/imx6q-display5.dtsi
@@ -255,7 +255,7 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	codec: tfa9879 at 6C {
+	codec: tfa9879 at 6c {
 		#sound-dai-cells = <0>;
 		compatible = "nxp,tfa9879";
 		reg = <0x6C>;
-- 
2.11.0
