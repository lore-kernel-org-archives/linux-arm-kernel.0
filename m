From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 21 Aug 2013 11:28:24 +0400
Subject: [PATCH 2/3] ARM: dts: i.MX51: Add IRAM devicetree node
In-Reply-To: <1377070105-15902-1-git-send-email-shc_work@mail.ru>
References: <1377070105-15902-1-git-send-email-shc_work@mail.ru>
Message-ID: <1377070105-15902-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing IRAM devicetree node for i.MX51 CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index b7cda0a..09ecf29 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -86,6 +86,11 @@
 		interrupt-parent = <&tzic>;
 		ranges;
 
+		iram: iram at 1ffe0000 {
+			compatible = "mmio-sram";
+			reg = <0x1ffe0000 0x20000>;
+		};
+
 		ipu: ipu at 40000000 {
 			#crtc-cells = <1>;
 			compatible = "fsl,imx51-ipu";
-- 
1.8.1.5
