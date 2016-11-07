From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon,  7 Nov 2016 11:43:57 +0100
Subject: [PATCH 3/3] ARM64: dts: meson-gxl-s905x: Enable internal ethernet PHY
In-Reply-To: <20161107104357.24428-1-narmstrong@baylibre.com>
References: <20161107104357.24428-1-narmstrong@baylibre.com>
Message-ID: <20161107104357.24428-4-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
index 07f0e0b..08237ee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
@@ -46,3 +46,9 @@
 / {
 	compatible = "amlogic,s905x", "amlogic,meson-gxl";
 };
+
+/* S905X Only has access to its internal PHY */
+&ethmac {
+	phy-mode = "rmii";
+	phy-handle = <&internal_phy>;
+};
-- 
2.7.0
