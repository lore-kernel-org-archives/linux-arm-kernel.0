From: cosardindar@gmail.com (Cosar Dindar)
Date: Mon, 22 May 2017 17:34:56 +0300
Subject: [PATCH v3 4/5] ARM: dts: stm32: enable CRC32 on stm32429-disco board
In-Reply-To: <cover.1495463449.git.cosardindar@gmail.com>
References: <cover.1495463449.git.cosardindar@gmail.com>
Message-ID: <43babcf91eb49c5dffc4164b87839eeb537f0ee1.1495463449.git.cosardindar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the CRC32 crypto on stm32429-disco board.

Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 191fa50..ae47cde 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -102,6 +102,10 @@
 	clock-frequency = <8000000>;
 };
 
+&crc {
+	status = "okay";
+};
+
 &rtc {
 	assigned-clocks = <&rcc 1 CLK_RTC>;
 	assigned-clock-parents = <&rcc 1 CLK_LSI>;
-- 
2.7.4
