From: zonque@gmail.com (Daniel Mack)
Date: Thu, 22 Aug 2013 13:37:28 +0200
Subject: [PATCH 4/4] ARM: dts: am33xx: add third memory region to cpsw block
In-Reply-To: <1377171448-27924-1-git-send-email-zonque@gmail.com>
References: <1377171448-27924-1-git-send-email-zonque@gmail.com>
Message-ID: <1377171448-27924-5-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This third memory region just denotes one single register in the CONTROL
module block. The driver uses that in order to set the correct physical
ethernet interface modes.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index a785b95..4ac4e4c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
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
