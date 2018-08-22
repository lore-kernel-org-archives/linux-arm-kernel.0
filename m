From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 22 Aug 2018 22:43:07 +0200
Subject: [PATCH 14/14] DT: marvell,mmp2: add USB OTG host controller
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <20180822204307.13251-15-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 14a3448f38b9..63d4d5c6fd83 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -124,6 +124,17 @@
 				#phy-cells = <0>;
 				status = "disabled";
 			};
+
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
 		};
 
 		apb at d4000000 {	/* APB */
-- 
2.17.1
