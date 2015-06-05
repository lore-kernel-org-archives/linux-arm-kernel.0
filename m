From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 05 Jun 2015 19:05:43 +0200
Subject: [PATCH v4 1/3] dt-bindings: describe dw_hdmi supplies
Message-ID: <1707049.JEvfTcofKv@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Designware HDMI block has two supplies for 1.0 and 1.8V. Not all IP
implementations expose or want to use these, so they remain optional.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
changes since v3:
- split generic dt-bindings and rockchip implementation
- add Ack from Philipp Zabel
changes since v2:
- rename supplies to the names found in the hdmi IP databook

 Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
index a905c14..ba42d89 100644
--- a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
+++ b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
@@ -22,6 +22,10 @@ Optional properties
 - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
 - clocks, clock-names: phandle to the HDMI CEC clock, name should be "cec"
 
+Optional supplies:
+- vp-supply: 1.0V power supply
+- vph-supply: 1.8V power supply
+
 Example:
 	hdmi: hdmi at 0120000 {
 		compatible = "fsl,imx6q-hdmi";
-- 
2.1.4
