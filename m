From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:58:51 +0200
Subject: [PATCH 18/35] arm64: dts: salvator-x: Add current sense amplifiers
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <c3dc4604131940908b922e3b3c36c3ea3ee4df55.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add device nodes for two Maxim max961x current sense amplifiers
sensing VDD_08 and DVFS_08 lines.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
[geert: r8a7796-salvator-x.dts => salvator-x.dtsi]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-x.dtsi b/arch/arm64/boot/dts/renesas/salvator-x.dtsi
index 47a482f20c9d..d5eb022d247c 100644
--- a/arch/arm64/boot/dts/renesas/salvator-x.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-x.dtsi
@@ -283,6 +283,24 @@
 	};
 };
 
+&i2c4 {
+	status = "okay";
+
+	csa_vdd: adc at 7c {
+		compatible = "maxim,max9611";
+		reg = <0x7c>;
+
+		shunt-resistor-micro-ohms = <5000>;
+	};
+
+	csa_dvfs: adc at 7f {
+		compatible = "maxim,max9611";
+		reg = <0x7f>;
+
+		shunt-resistor-micro-ohms = <5000>;
+	};
+};
+
 &i2c_dvfs {
 	status = "okay";
 };
-- 
2.1.4
