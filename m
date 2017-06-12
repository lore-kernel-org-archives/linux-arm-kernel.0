From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 12 Jun 2017 11:32:16 +0200
Subject: [PATCH 1/2] arm64: dts: r8a7795: Add reset control properties for
 audio
In-Reply-To: <1497259937-9387-1-git-send-email-geert+renesas@glider.be>
References: <1497259937-9387-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1497259937-9387-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that the audio module has resets for the Serial Sound Interfaces
only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 65c914bba08235a5..18651d39a89a8b54 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1119,6 +1119,16 @@
 				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 1005>,
+				 <&cpg 1006>, <&cpg 1007>,
+				 <&cpg 1008>, <&cpg 1009>,
+				 <&cpg 1010>, <&cpg 1011>,
+				 <&cpg 1012>, <&cpg 1013>,
+				 <&cpg 1014>, <&cpg 1015>;
+			reset-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0";
 			status = "disabled";
 
 			rcar_sound,dvc {
-- 
2.7.4
