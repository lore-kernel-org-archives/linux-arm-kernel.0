From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 28 Nov 2018 18:53:13 +0100
Subject: [PATCH v4 09/20] DT: marvell,mmp2: add USB OTG host controller
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
Message-ID: <20181128175324.163202-10-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/dts/mmp2.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 57f6248f17cd..0c5a51b98c3f 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -125,6 +125,17 @@
 				status = "disabled";
 			};
 
+			usb_otg0: usb-otg at d4208000 {
+				compatible = "marvell,pxau2o-ehci";
+				reg = <0xd4208000 0x200>;
+				interrupts = <44>;
+				clocks = <&soc_clocks MMP2_CLK_USB>;
+				clock-names = "USBCLK";
+				phys = <&usb_otg_phy0>;
+				phy-names = "usb";
+				status = "disabled";
+			};
+
 			mmc1: mmc at d4280000 {
 				compatible = "mrvl,pxav3-mmc";
 				reg = <0xd4280000 0x120>;
-- 
2.19.1
