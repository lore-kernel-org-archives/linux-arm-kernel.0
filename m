From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 20 Nov 2017 15:19:56 +0100
Subject: [PATCH v2 3/4] ARM64: dts: meson-gx: grow reset controller memory zone
In-Reply-To: <1511187597-18248-1-git-send-email-narmstrong@baylibre.com>
References: <1511187597-18248-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1511187597-18248-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the Amlogic Meson GX SoCs datasheet documents all the Reset registers,
grow the memory in the node to allow usage of the level registers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 668d891..7cdbf58 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -229,7 +229,7 @@
 
 			reset: reset-controller at 4404 {
 				compatible = "amlogic,meson-gx-reset", "amlogic,meson-gxbb-reset";
-				reg = <0x0 0x04404 0x0 0x20>;
+				reg = <0x0 0x04404 0x0 0x9c>;
 				#reset-cells = <1>;
 			};
 
-- 
2.7.4
