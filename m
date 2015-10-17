From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 17 Oct 2015 19:23:56 +0200
Subject: [PATCH 7/9] ARM: dts: Add GPIO irq support to STM2F429
In-Reply-To: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1445102638-11575-8-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index a2c3aaa..bc84e8b 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -169,6 +169,11 @@
 			status = "disabled";
 		};
 
+		syscfg: system-config at 40013800 {
+			compatible = "syscon";
+			reg = <0x40013800 0x400>;
+		};
+
 		exti: interrupt-controller at 40013c00 {
 			compatible = "st,stm32-exti";
 			interrupt-controller;
@@ -182,6 +187,8 @@
 			#size-cells = <1>;
 			compatible = "st,stm32f429-pinctrl";
 			ranges = <0 0x40020000 0x3000>;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&syscfg 0x8>;
 			pins-are-numbered;
 
 			gpioa: gpio at 40020000 {
-- 
1.9.1
