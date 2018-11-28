From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 28 Nov 2018 18:53:12 +0100
Subject: [PATCH v4 08/20] DT: marvell,mmp2: add OTG PHY
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
Message-ID: <20181128175324.163202-9-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB OTG PHY chip. To be used by the OTG controller.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/dts/mmp2.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index c48d17a38d6b..57f6248f17cd 100644
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
