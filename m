From: joelf@ti.com (Joel Fernandes)
Date: Wed, 25 Sep 2013 17:01:02 -0500
Subject: [PATCH 2/9] omap4: dts: Add node for DES3DES module
In-Reply-To: <1380146469-29496-1-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
Message-ID: <1380146469-29496-3-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 has an DES3DES  module that uses the omap-des crypto driver.
Add DT entries for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4267a74..0e72401 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -673,5 +673,15 @@
 			dmas = <&sdma 111>, <&sdma 110>;
 			dma-names = "tx", "rx";
 		};
+
+		des: des at 480A5000 {
+			compatible = "ti,omap4-des";
+			ti,hwmods = "des";
+			reg = <0x480a5000 0xa0>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 82 0x4>;
+			dmas = <&sdma 117>, <&sdma 116>;
+			dma-names = "tx", "rx";
+		};
 	};
 };
-- 
1.8.1.2
