From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:10 +0200
Subject: [PATCH 15/58] arm64: dts: renesas: r8a77965: Add CAN{0,
 1} placeholder nodes
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <92bc66bfce99cd7d5b66cb1086812a32300c5705.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eugeniu Rosca <roscaeugeniu@gmail.com>

According to R-Car Gen3 HW manual rev1.00, R-Car M3-N has two CAN
interfaces, similar to H3, M3-W and other SoCs from the same family.

Add CAN placeholder nodes to avoid below DTC errors:
Error: arch/arm64/boot/dts/renesas/ulcb-kf.dtsi:19.1-6 Label or path can0 not found
Error: arch/arm64/boot/dts/renesas/ulcb-kf.dtsi:25.1-6 Label or path can1 not found

These errors occur *after* the addition of r8a77965-m3nulcb-kf.dts.
Fix them beforehand.

CAN support is inspired from below commits:
 - v4.7 commit 308b7e4ba62e ("arm64: dts: r8a7795: Add CAN support")
 - v4.11 commit 909c16252415 ("arm64: dts: r8a7796: Add CAN support")
 - v4.12 commit bec0948e810f ("arm64: dts: r8a7796: Add reset control properties")

Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
[simon: make placeholder minimal by only including reg property]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 7a75c351edd2..e7128fb65e33 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -862,6 +862,16 @@
 			status = "disabled";
 		};
 
+		can0: can at e6c30000 {
+			reg = <0 0xe6c30000 0 0x1000>;
+			/* placeholder */
+		};
+
+		can1: can at e6c38000 {
+			reg = <0 0xe6c38000 0 0x1000>;
+			/* placeholder */
+		};
+
 		pwm0: pwm at e6e30000 {
 			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
 			reg = <0 0xe6e30000 0 8>;
-- 
2.11.0
