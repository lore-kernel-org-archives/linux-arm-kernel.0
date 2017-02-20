From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 20 Feb 2017 21:33:28 +0100
Subject: [PATCH/RFC 5/6] arm64: dts: r8a7795: Fix non-PMIC wake-up sources
In-Reply-To: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1487622809-25127-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCI firmware on boards equipped with an R-Car H3 SoC implements the
PSCI SYSTEM_SUSPEND operation by cutting power to the SoC.  Hence the
only possibly wake-up sources are the ones connected to the PMIC, unless
the "arm,psci-system-suspend-is-power-down" property is specified.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f05a9c4dd3b60c82..cf43e9c7cab224b2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -31,6 +31,7 @@
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
+		arm,psci-system-suspend-is-power-down;
 	};
 
 	cpus {
-- 
2.7.4
