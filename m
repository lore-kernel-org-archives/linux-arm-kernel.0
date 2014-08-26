From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Aug 2014 14:23:58 +0900
Subject: [PATCH 4/8] ARM: shmobile: armadillo800eva-reference: add clock
 overrides to DTS
In-Reply-To: <cover.1409030383.git.horms+renesas@verge.net.au>
References: <cover.1409030383.git.horms+renesas@verge.net.au>
Message-ID: <ae2a8cdd5c52b4e205cc1e5abca31168fb20dadb.1409030383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index ee9e7d5..266c439 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -178,6 +178,19 @@
 	};
 };
 
+&extal1_clk {
+	clock-frequency = <25000000>;
+};
+&extal2_clk {
+	clock-frequency = <48000000>;
+};
+&fsibck_clk {
+	clock-frequency = <12288000>;
+};
+&cpg_clocks {
+	renesas,mode = <0x05>; /* MD_CK0 | MD_CK2 */
+};
+
 &i2c0 {
 	status = "okay";
 	touchscreen at 55 {
-- 
2.0.1
