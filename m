From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 1 Apr 2015 17:17:33 +0530
Subject: [RESEND PATCH 3/8] doc/bindings: Update clk-qoriq bindings for FSL's
 chassis-3.0 SoCs
In-Reply-To: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1427888858-29636-4-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the 'clk-qoriq' device-tree bindings for
chassis-3.0 compliant SoCs from FSL, for e.g. LS2085A

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 .../devicetree/bindings/clock/qoriq-clock.txt      |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index df4a259..60d758e 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -14,6 +14,7 @@ Chassis Version		Example Chips
 ---------------		-------------
 1.0			p4080, p5020, p5040
 2.0			t4240, b4860, t1040
+3.0			ls2085a
 
 1. Clock Block Binding
 
@@ -30,9 +31,11 @@ Required properties:
 	* "fsl,b4420-clockgen"
 	* "fsl,b4860-clockgen"
 	* "fsl,ls1021a-clockgen"
+	* "fsl,ls2085a-clockgen"
 	Chassis clock strings include:
 	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
 	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
+	* "fsl,qoriq-clockgen-3.0": for chassis 3.0 clocks
 - reg: Describes the address of the device's resources within the
 	address space defined by its parent bus, and resource zero
 	represents the clock register set
@@ -57,18 +60,23 @@ Required properties:
 - compatible : Should include one of the following:
 	* "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
 	* "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
+	* "fsl,qoriq-core-pll-3.0" for core PLL clocks (v3.0)
 	* "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
 	* "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
+	* "fsl,qoriq-core-mux-3.0" for core mux clocks (v3.0)
 	* "fsl,qoriq-sysclk-1.0": for input system clock (v1.0).
 		It takes parent's clock-frequency as its clock.
 	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0).
 		It takes parent's clock-frequency as its clock.
+	* "fsl,qoriq-sysclk-3.0": for input system clock (v3.0).
+		It takes parent's clock-frequency as its clock.
 	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
 	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
+	* "fsl,qoriq-platform-pll-3.0" for the platform PLL clock (v3.0)
 - #clock-cells: From common clock binding. The number of cells in a
-	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
-	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
-	For "fsl,qoriq-core-pll-[1,2].0" clocks, the single
+	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2,3].0"
+	clocks, or <1> for "fsl,qoriq-core-pll-[1,2,3].0" clocks.
+	For "fsl,qoriq-core-pll-[1,2,3].0" clocks, the single
 	clock-specifier cell may take the following values:
 	* 0 - equal to the PLL frequency
 	* 1 - equal to the PLL frequency divided by 2
-- 
1.7.9.5
