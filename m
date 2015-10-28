From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 28 Oct 2015 16:02:16 -0500
Subject: [PATCH 1/2] ARM: dts: omap4: Add elm node
In-Reply-To: <1446066137-11527-1-git-send-email-fcooper@ti.com>
References: <1446066137-11527-1-git-send-email-fcooper@ti.com>
Message-ID: <1446066137-11527-2-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree entry for the error location module.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 5a206c1..a40eb23 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -348,6 +348,14 @@
 			#interrupt-cells = <2>;
 		};
 
+		elm: elm at 48078000 {
+			compatible = "ti,am3352-elm";
+			reg = <0x48078000 0x2000>;
+			interrupts = <4>;
+			ti,hwmods = "elm";
+			status = "disabled";
+		};
+
 		gpmc: gpmc at 50000000 {
 			compatible = "ti,omap4430-gpmc";
 			reg = <0x50000000 0x1000>;
-- 
2.6.1
