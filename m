From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:35 +0200
Subject: [PATCH 4/9] arm64: dts: renesas: salvator-common: Prefer HSCIF1 over
 SCIF1
In-Reply-To: <cover.1532087303.git.horms+renesas@verge.net.au>
References: <cover.1532087303.git.horms+renesas@verge.net.au>
Message-ID: <e3853498f25d4c64a4175b42b6d7625fe0b90038.1532087303.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

HSCIF is superior to SCIF (larger FIFOs, more accurate and wider
supported range of bitrates).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 6439d05fd7ec..9687166c4473 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -33,7 +33,7 @@
 / {
 	aliases {
 		serial0 = &scif2;
-		serial1 = &scif1;
+		serial1 = &hscif1;
 		ethernet0 = &avb;
 	};
 
@@ -344,7 +344,7 @@
 
 	uart-has-rtscts;
 	/* Please only enable hscif1 or scif1 */
-	/* status = "okay"; */
+	status = "okay";
 };
 
 &hsusb {
@@ -723,7 +723,7 @@
 
 	uart-has-rtscts;
 	/* Please only enable hscif1 or scif1 */
-	status = "okay";
+	/* status = "okay"; */
 };
 
 &scif2 {
-- 
2.11.0
