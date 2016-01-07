From: ykk@rock-chips.com (Yakir Yang)
Date: Thu,  7 Jan 2016 17:05:11 +0800
Subject: [RFC PATCH v2 4/4] dt-bindings: add document for rk3229-hdmi
In-Reply-To: <1452156811-18150-1-git-send-email-ykk@rock-chips.com>
References: <1452156811-18150-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1452157511-18891-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v2: None

 .../devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
index 668091f..1cdc627 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
@@ -2,7 +2,7 @@ Rockchip specific extensions to the Synopsys Designware HDMI
 ================================
 
 Required properties:
-- compatible: "rockchip,rk3288-dw-hdmi";
+- compatible: "rockchip,rk3288-dw-hdmi", "rockchip,rk3229-dw-hdmi";
 - reg: Physical base address and length of the controller's registers.
 - clocks: phandle to hdmi iahb and isfr clocks.
 - clock-names: should be "iahb" "isfr"
@@ -15,8 +15,10 @@ Required properties:
   rk3288 platform
 
 Optional properties
+- reg: Physical base address and length of the external HDMI PHY's registers.
 - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
 - clocks, clock-names: phandle to the HDMI CEC clock, name should be "cec"
+		       phandle to the external HDMI PHY clock, name should be "extphy"
 
 Example:
 hdmi: hdmi at ff980000 {
-- 
2.1.2
