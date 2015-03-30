From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 30 Mar 2015 16:17:11 +0100
Subject: [PATCH v2 5/6] usb: dwc3: dwc3-st: Update the incorrect DT dwc3
 example.
In-Reply-To: <1427728632-10846-1-git-send-email-peter.griffin@linaro.org>
References: <1427728632-10846-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1427728632-10846-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a subtle typo phys-names should be phy-names. Using the
current example means you don't have working usb (as you fail to
obtain the phys). Also update the example to use the generic phy
type constants which are now used for miphy28.

Additionaly also remove the unnecessary new line in the example.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/dwc3-st.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-st.txt b/Documentation/devicetree/bindings/usb/dwc3-st.txt
index f9d7025..01c71b1 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-st.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3-st.txt
@@ -49,8 +49,7 @@ st_dwc3: dwc3 at 8f94000 {
 	st,syscfg	= <&syscfg_core>;
 	resets		= <&powerdown STIH407_USB3_POWERDOWN>,
 			  <&softreset STIH407_MIPHY2_SOFTRESET>;
-	reset-names	= "powerdown",
-			  "softreset";
+	reset-names	= "powerdown", "softreset";
 	#address-cells	= <1>;
 	#size-cells	= <1>;
 	pinctrl-names	= "default";
@@ -62,7 +61,7 @@ st_dwc3: dwc3 at 8f94000 {
 		reg		= <0x09900000 0x100000>;
 		interrupts	= <GIC_SPI 155 IRQ_TYPE_NONE>;
 		dr_mode		= "host";
-		phys-names      = "usb2-phy", "usb3-phy";
-		phys            = <&usb2_picophy2>, <&phy_port2 MIPHY_TYPE_USB>;
+		phy-names	= "usb2-phy", "usb3-phy";
+		phys		= <&usb2_picophy2>, <&phy_port2 PHY_TYPE_USB3>;
 	};
 };
-- 
1.9.1
