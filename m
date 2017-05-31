From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 31 May 2017 15:41:48 +0200
Subject: [PATCH v2 04/11] dt-bindings: cp110: do not depend anymore of the
 *-clock-output-names
In-Reply-To: <cover.d3a417499f4e5f039deaa27832bf6eccdd090a6f.1496237893.git-series.gregory.clement@free-electrons.com>
References: <cover.d3a417499f4e5f039deaa27832bf6eccdd090a6f.1496237893.git-series.gregory.clement@free-electrons.com>
Message-ID: <6701a6c918ba8c89ef667e0ecc4fc249738a6a57.1496237893.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the documentation according to the change made in the
patch "clk: mvebu: cp110: do not depend anymore of the
*-clock-output-names": the clock names are no more part of the binding.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
index eb6cf44caa0f..47f1cf800e25 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
@@ -59,14 +59,6 @@ Required properties:
      "marvell,cp110-system-controller0", "syscon";
  - reg: register area of the CP110 system controller 0
  - #clock-cells: must be set to 2
- - core-clock-output-names must be set to:
-	"cpm-apll", "cpm-ppv2-core", "cpm-eip", "cpm-core", "cpm-nand-core"
- - gate-clock-output-names must be set to:
-	"cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
-	"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "none",
-	"cpm-pcie_x10", "cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata",
-	"cpm-sata-usb", "cpm-main", "cpm-gop", "none", "none", "cpm-slow-io",
-	"cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 
 Example:
 
@@ -74,10 +66,4 @@ Example:
 		compatible = "marvell,cp110-system-controller0", "syscon";
 		reg = <0x440000 0x1000>;
 		#clock-cells = <2>;
-		core-clock-output-names = "cpm-apll", "cpm-ppv2-core", "cpm-eip", "cpm-core", "cpm-nand-core";
-		gate-clock-output-names = "cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
-			"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "none",
-			"cpm-pcie_x10", "cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata",
-			"cpm-sata-usb", "cpm-main", "cpm-gop", "none", "none", "cpm-slow-io",
-			"cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 	};
-- 
git-series 0.9.1
