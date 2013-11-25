From: matt.porter@linaro.org (Matt Porter)
Date: Mon, 25 Nov 2013 13:16:00 -0500
Subject: [PATCH v3 2/9] staging: dwc2: update DT binding to add generic
 clock/phy properties
In-Reply-To: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
References: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1385403367-18144-3-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwc2/s3c-hsotg require a single clock to be specified and optionally
a generic phy. On the s3c-hsotg driver old style USB phy support is
present as a fallback so the generic phy properties are optional.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
---
 Documentation/devicetree/bindings/staging/dwc2.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/staging/dwc2.txt b/Documentation/devicetree/bindings/staging/dwc2.txt
index 1a1b7cf..b8b42b6 100644
--- a/Documentation/devicetree/bindings/staging/dwc2.txt
+++ b/Documentation/devicetree/bindings/staging/dwc2.txt
@@ -5,6 +5,12 @@ Required properties:
 - compatible : "snps,dwc2"
 - reg : Should contain 1 register range (address and length)
 - interrupts : Should contain 1 interrupt
+- clocks: clock provider specifier
+- clock-names: shall be "otg"
+- phys: phy provider specifier
+- phy-names: shall be "device"
+Refer to clk/clock-bindings.txt for generic clock consumer properties
+Refer to phy/phy-bindings.txt for generic phy consumer properties
 
 Example:
 
@@ -12,4 +18,8 @@ Example:
                 compatible = "ralink,rt3050-usb, snps,dwc2";
                 reg = <0x101c0000 40000>;
                 interrupts = <18>;
+		clocks = <&usb_otg_ahb_clk>;
+		clock-names = "otg";
+		phys = <&usbphy>;
+		phy-names = "device";
         };
-- 
1.8.4
