From: stefan@agner.ch (Stefan Agner)
Date: Mon, 26 Feb 2018 22:31:10 +0100
Subject: [PATCH] ARM: dts: imx6: Add chosen node
Message-ID: <20180226213110.3540-1-stefan@agner.ch>
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
