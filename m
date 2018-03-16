From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 16 Mar 2018 15:50:21 +0100
Subject: [PATCH] ARM64: dts: meson-gx: make efuse read-only
Message-ID: <20180316145021.8517-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

efuse is one time programmable, so it is safer to deny write request
to this memory, unless the user is savvy enough to remove the read-only
flag from DTB

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 2d51ccd60628..3c31e21cbed7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -132,6 +132,7 @@
 		compatible = "amlogic,meson-gx-efuse", "amlogic,meson-gxbb-efuse";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		read-only;
 
 		sn: sn at 14 {
 			reg = <0x14 0x10>;
-- 
2.14.3
