From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  5 Jul 2018 11:50:42 +0200
Subject: [PATCH 1/2] dt-bindings: amlogic: Add support for GXL S805X and the
 P241 board
In-Reply-To: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
References: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1530784243-20823-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S805X is a variant of the Amlogic Meson GXL SoC family with the
following physical limitations :
- No SDCard interface
- No GPIOCLK pins
- No USB OTG ID pin (but Gadget feature can stil be forced)
- No 5V regulator
- Reduced ADC inputs (only ADC0 and ADC1)
- GPIODV_26, GPIOAO_3, GPIOAO_4, GPIOAO_5, GPIOAO_6, GPIOX_14,
  GPIOX_15, GPIOH_3 are no more exposed on the package

Amlogic exposes the following SW limitations :
- HDMI max resolution should be 1080p60, VPU clock should be downgraded
- Video Decoding should be limited to 1080p60, VDEC clock should be downgraded
- CPU speed should be limited by SCPI OPP table to 1.2GHz
- DRAM interface is limited to DDR4 16bit up to 1GiB

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 6988056..849834c 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -41,6 +41,10 @@ Boards with the Amlogic Meson GXL S905D SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,s905d", "amlogic,meson-gxl";
 
+Boards with the Amlogic Meson GXL S805X SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,s805x", "amlogic,meson-gxl";
+
 Boards with the Amlogic Meson GXM S912 SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,s912", "amlogic,meson-gxm";
@@ -79,6 +83,8 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
 
+  - "amlogic,p241" (Meson gxl s805x)
+
   - "amlogic,q200" (Meson gxm s912)
   - "amlogic,q201" (Meson gxm s912)
   - "khadas,vim2" (Meson gxm s912)
-- 
2.7.4
