From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Jul 2018 01:35:29 +0100
Subject: [PATCH v2 15/18] arm64: dts: allwinner: a64: NanoPi-A64: Fix DCDC1
 voltage
In-Reply-To: <20180726003532.18751-1-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
Message-ID: <20180726003532.18751-16-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the NanoPi-A64 schematics, DCDC1 is connected to a voltage
rail named "VDD_SYS_3.3V". All users seem to expect 3.3V here: the
Ethernet PHY, the uSD card slot, the camera interface and the GPIO pins
on the headers.
Fix up the voltage on the regulator to lift it up to 3.3V.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 98dbff19f5cc..5caba225b4f7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -125,9 +125,9 @@
 
 &reg_dcdc1 {
 	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "vcc-3v";
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
 };
 
 &reg_dcdc2 {
-- 
2.14.4
