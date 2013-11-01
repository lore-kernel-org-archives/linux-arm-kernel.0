From: matt.porter@linaro.org (Matt Porter)
Date: Fri,  1 Nov 2013 15:45:51 -0400
Subject: [PATCH v2 2/9] staging: dwc2: update DT binding to add generic
 clock/phy properties
In-Reply-To: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1383335158-19730-3-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwc2/s3c-hsotg require a single clock to be specified and optionally
a generic phy. On the s3c-hsotg driver old style USB phy support is
present as a fallback so the generic phy properties are optional.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
---
 Documentation/devicetree/bindings/staging/dwc2.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/staging/dwc2.txt b/Documentation/devicetree/bindings/staging/dwc2.txt
index 1a1b7cf..f60477e 100644
--- a/Documentation/devicetree/bindings/staging/dwc2.txt
+++ b/Documentation/devicetree/bindings/staging/dwc2.txt
@@ -5,6 +5,14 @@ Required properties:
 - compatible : "snps,dwc2"
 - reg : Should contain 1 register range (address and length)
 - interrupts : Should contain 1 interrupt
+- clocks: clock provider specifier
+- clock-names: shall be "otg"
+Refer to clk/clock-bindings.txt for generic clock consumer properties
+
+Optional properties:
+- phys: phy provider specifier
+- phy-names: shall be "usb2-phy"
+Refer to phy/phy-bindings.txt for generic phy consumer properties
 
 Example:
 
@@ -12,4 +20,8 @@ Example:
                 compatible = "ralink,rt3050-usb, snps,dwc2";
                 reg = <0x101c0000 40000>;
                 interrupts = <18>;
+		clocks = <&usb_otg_ahb_clk>;
+		clock-names = "otg";
+		phys = <&usbphy>;
+		phy-names = "usb2-phy";
         };
-- 
1.8.4
