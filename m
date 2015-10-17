From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 17 Oct 2015 19:23:53 +0200
Subject: [PATCH 4/9] ARM: dts: Add EXTI controller node to stm32f429
In-Reply-To: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1445102638-11575-5-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index eb3580e..a2c3aaa 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -169,6 +169,14 @@
 			status = "disabled";
 		};
 
+		exti: interrupt-controller at 40013c00 {
+			compatible = "st,stm32-exti";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x40013C00 0x400>;
+			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
+		};
+
 		pin-controller {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.9.1
