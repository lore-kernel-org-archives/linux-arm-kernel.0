From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 17 Oct 2017 10:07:42 +0200
Subject: [PATCH 2/4] dt-bindings: display: amlogic,
 meson-dw-hdmi: Add optional HDMI 5V regulator
In-Reply-To: <1508227664-11171-1-git-send-email-narmstrong@baylibre.com>
References: <1508227664-11171-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1508227664-11171-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On reference boards and derivatives, the HDMI Logic is powered by an external
5V regulator.
This regulator was set by the Vendor U-Boot, add optional support for it.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
index 7f040ed..bf4a180 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
@@ -48,6 +48,10 @@ Required properties:
   Documentation/devicetree/bindings/reset/reset.txt,
   the reset-names should be "hdmitx_apb", "hdmitx", "hdmitx_phy"
 
+Optional properties:
+- hdmi-supply: Optional phandle to an external 5V regulator to power the HDMI
+  logic, as described in the file ../regulator/regulator.txt
+
 Required nodes:
 
 The connections to the HDMI ports are modeled using the OF graph
-- 
2.7.4
