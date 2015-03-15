From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 16 Mar 2015 08:03:06 +0900
Subject: [PATCH 2/5] ARM: shmobile: koelsch dts: Add da9210 regulator interrupt
In-Reply-To: <cover.1426456462.git.horms+renesas@verge.net.au>
References: <cover.1426456462.git.horms+renesas@verge.net.au>
Message-ID: <4be7338df39037266da832f6598557cc4ca3de10.1426456462.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The da9210 regulator is connected to IRQ2. Reflect this in its device
node, so the driver can use it when it gains interrupt support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index a3c2780..213a643 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -520,6 +520,8 @@
 	vdd_dvfs: regulator at 68 {
 		compatible = "dlg,da9210";
 		reg = <0x68>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 
 		regulator-min-microvolt = <1000000>;
 		regulator-max-microvolt = <1000000>;
-- 
2.1.4
