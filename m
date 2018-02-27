From: stefan@agner.ch (Stefan Agner)
Date: Tue, 27 Feb 2018 09:00:23 +0100
Subject: [PATCH v2] ARM: dts: imx6dl-colibri-eval-v3: Add chosen node
Message-ID: <20180227080023.17682-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Colibri UART_A as default serial console.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index dcf9206f3e0d..d4f5c6862d27 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -63,6 +63,10 @@
 		rtc1 = &snvs_rtc;
 	};
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	clocks {
 		/* Fixed crystal dedicated to mcp251x */
 		clk16m: clk at 1 {
-- 
2.16.2
