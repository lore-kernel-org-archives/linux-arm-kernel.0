From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon, 26 Aug 2013 14:35:40 +0200
Subject: [PATCH v2 2/2] ARM: at91/dt: define phy available on sama5d3 mother
 board
In-Reply-To: <1377520431-21807-1-git-send-email-b.brezillon@overkiz.com>
References: <1377520431-21807-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1377520540-21884-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describe the phy used on atmel sama5d3 mother board:
 - phy address
 - phy interrupt pin

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/sama5d3xmb.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 8a9e05d..e9521d5 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -81,6 +81,14 @@
 
 			macb1: ethernet at f802c000 {
 				phy-mode = "rmii";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+				phy0: ethernet-phy at 0 {
+					interrupt-parent = <&pioE>;
+					interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+					reg = <1>;
+				};
 			};
 
 			pinctrl at fffff200 {
-- 
1.7.9.5
