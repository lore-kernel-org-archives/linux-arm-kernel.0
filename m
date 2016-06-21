From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 21 Jun 2016 12:02:48 +0200
Subject: [RFC PATCH v2 3/9] ARM64: dts: meson-gxbb: Add Meson MHU Node
In-Reply-To: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1466503374-28841-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 806b903..77381d0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -315,6 +315,14 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
+
+			mailbox: mailbox at 400 {
+				compatible = "amlogic,meson-gxbb-mhu";
+				reg = <0 0x400 0 0x4c>;
+				interrupts = <0 209 IRQ_TYPE_EDGE_RISING>,
+					     <0 210 IRQ_TYPE_EDGE_RISING>;
+				#mbox-cells = <1>;
+			 };
 		};
 
 		apb: apb at d0000000 {
-- 
2.7.0
