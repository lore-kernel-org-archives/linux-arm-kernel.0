From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:11 +0900
Subject: [PATCH 03/10] arm64: dts: r8a7795: Add PSCI node
In-Reply-To: <cover.1450401186.git.horms+renesas@verge.net.au>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
Message-ID: <12e5155783bfdd50d93f9868b2209db190df8b68.1450401186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Add PSCI node for r8a7795 SoC, and cpu node enable-method property is
set to "psci".

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b1902ea1dae4..051ff143506e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -26,6 +26,11 @@
 		i2c6 = &i2c6;
 	};
 
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -35,6 +40,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
 			device_type = "cpu";
+			enable-method = "psci";
 		};
 	};
 
-- 
2.1.4
