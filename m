From: zonque@gmail.com (Daniel Mack)
Date: Fri, 23 Aug 2013 21:32:10 +0200
Subject: [PATCH v6 5/5] ARM: dts: am33xx: adopt to cpsw changes
In-Reply-To: <1377286330-29663-1-git-send-email-zonque@gmail.com>
References: <1377286330-29663-1-git-send-email-zonque@gmail.com>
Message-ID: <1377286330-29663-6-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This third memory region just denotes one single register in the CONTROL
module block. The driver uses that in order to set the correct physical
ethernet interface modes.

Also update the compatible string to make use of the am335x specific
features of the cpsw driver.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index a785b95..c7b41ae 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -446,7 +446,7 @@
 		};
 
 		mac: ethernet at 4a100000 {
-			compatible = "ti,cpsw";
+			compatible = "ti,am3352-cpsw", "ti,cpsw";
 			ti,hwmods = "cpgmac0";
 			cpdma_channels = <8>;
 			ale_entries = <1024>;
@@ -459,7 +459,8 @@
 			cpts_clock_mult = <0x80000000>;
 			cpts_clock_shift = <29>;
 			reg = <0x4a100000 0x800
-			       0x4a101200 0x100>;
+			       0x4a101200 0x100
+			       0x44e10650 0x4>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			interrupt-parent = <&intc>;
-- 
1.8.3.1
