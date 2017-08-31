From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 31 Aug 2017 17:39:50 +0200
Subject: [PATCH 1/2] ARM: dts: imx6: RDU2: disable over-current detection on
 USB H1
Message-ID: <20170831153951.7674-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like the OTG port, USB H1 has no over-current detection wired up.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 34f24570df9e..c2cd7457bad3 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -805,6 +805,7 @@
 
 &usbh1 {
 	vbus-supply = <&reg_5p0v_main>;
+	disable-over-current;
 	status = "okay";
 };
 
-- 
2.11.0
