From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  9 Aug 2016 10:52:17 +0200
Subject: [PATCH 3/3] ARM64: dts: meson-gxbb: Add Meson MHU Node
In-Reply-To: <1470732737-18391-1-git-send-email-narmstrong@baylibre.com>
References: <1470732737-18391-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1470732737-18391-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index e502c24..dfd2ff7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -321,6 +321,14 @@
 				#clock-cells = <1>;
 				reg = <0x0 0x0 0x0 0x3db>;
 			};
+
+			mailbox: mailbox at 400 {
+				compatible = "amlogic,meson-gxbb-mhu";
+				reg = <0 0x400 0 0x4c>;
+				interrupts = <0 209 IRQ_TYPE_EDGE_RISING>,
+					     <0 210 IRQ_TYPE_EDGE_RISING>;
+				#mbox-cells = <1>;
+			};
 		};
 
 		apb: apb at d0000000 {
-- 
2.7.0
