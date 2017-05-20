From: cosardindar@gmail.com (Cosar Dindar)
Date: Sat, 20 May 2017 16:33:19 +0300
Subject: [PATCH v2 5/5] ARM: dts: stm32: Add CRC support to stm32f429
In-Reply-To: <cover.1495285223.git.cosardindar@gmail.com>
References: <cover.1495285223.git.cosardindar@gmail.com>
Message-ID: <fb1c9f073b72f7337ceccb219e59c633853789ee.1495285223.git.cosardindar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CRC32 Crypto support to stm32f429.

Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index b2a2b5c..18343de 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -766,6 +766,13 @@
 			};
 		};
 
+		crc: crc at 40023000 {
+			compatible = "st,stm32f4-crc";
+			reg = <0x40023000 0x400>;
+			clocks = <&rcc 0 STM32F4_AHB1_CLOCK(CRC)>;
+			status = "disabled";
+		};
+
 		rcc: rcc at 40023810 {
 			#reset-cells = <1>;
 			#clock-cells = <2>;
-- 
2.7.4
