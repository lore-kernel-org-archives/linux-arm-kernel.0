From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 Feb 2015 13:36:16 +0000
Subject: [PATCH 5/6] usb: dwc3: dwc3-st: Update the DT example.
In-Reply-To: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
References: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1424871377-1795-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a subtle type phys-names should be phy-names. Using the
current example means you don't have working usb. Also update
the example to use the generic phy type constants which are now
used for miphy28.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/usb/dwc3-st.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-st.txt b/Documentation/devicetree/bindings/usb/dwc3-st.txt
index f9d7025..6634064 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-st.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3-st.txt
@@ -62,7 +62,7 @@ st_dwc3: dwc3 at 8f94000 {
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
