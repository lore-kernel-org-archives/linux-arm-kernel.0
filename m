From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sat,  3 Oct 2015 21:35:19 +0100
Subject: [PATCH 3/3] ARM: dts: stm32f429: Adopt STM32 RNG driver
In-Reply-To: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
References: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1443904519-24012-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New bindings and driver have been created for STM32 series parts. This
patch integrates this changes.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/boot/dts/stm32f429.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index cb0613090243..90081fc22c6c 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -175,6 +175,13 @@
 			reg = <0x40023800 0x400>;
 			clocks = <&clk_hse>;
 		};
+
+		rng: rng at 50060800 {
+			compatible = "st,stm32-rng";
+			reg = <0x50060800 0x400>;
+			interrupts = <80>;
+			clocks = <&rcc 0 38>;
+		};
 	};
 };
 
-- 
2.4.3
