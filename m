From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 22 Aug 2018 22:43:06 +0200
Subject: [PATCH 13/14] DT: marvell,mmp2: add OTG PHY
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <20180822204307.13251-14-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB OTG PHY chip. To be used by the OTG controller.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..14a3448f38b9 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -117,6 +117,13 @@
 				reg-names = "mux status", "mux mask";
 				mrvl,intc-nr-irqs = <2>;
 			};
+
+			usb_otg_phy0: usb-otg-phy at d4207000 {
+				compatible = "marvell,mmp2-usb-phy";
+				reg = <0xd4207000 0x40>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		apb at d4000000 {	/* APB */
-- 
2.17.1
