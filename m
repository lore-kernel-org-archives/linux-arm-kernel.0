From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:17 +0100
Subject: [PATCH v3 08/18] DT: marvell,mmp2: add OTG PHY
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-9-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB OTG PHY chip. To be used by the OTG controller.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/dts/mmp2.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 7549680ab2e3..6ca1e17b6ac2 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -118,6 +118,13 @@
 				mrvl,intc-nr-irqs = <2>;
 			};
 
+			usb_otg_phy0: usb-otg-phy at d4207000 {
+				compatible = "marvell,mmp2-usb-phy";
+				reg = <0xd4207000 0x40>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
 			mmc1: mmc at d4280000 {
 				compatible = "mrvl,pxav3-mmc";
 				reg = <0xd4280000 0x120>;
-- 
2.19.1
