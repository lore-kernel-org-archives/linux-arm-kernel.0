From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 21 Mar 2017 16:36:11 +0100
Subject: [PATCH v3 11/11] ARM: sun8i: sina33: add highest OPP of CPUs
In-Reply-To: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Message-ID: <20170321153611.16228-12-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A33 supports 1.1GHz and 1.2GHz frequencies at 1.32V and the Sinlinx
SinA33 has its cpu-supply property set in the cpu DT node.

Therefore, CPUfreq knows how to handle the regulator in charge of the
CPU and can adjust its voltage to match the OPP.

Add these two CPU frequencies to the CPU OPP table of the Sinlinx
SinA33.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v3

 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index d84f1bd..a92dee1 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -87,6 +87,20 @@
 	cpu-supply = <&reg_dcdc3>;
 };
 
+&cpu0_opp_table {
+	opp at 1104000000 {
+		opp-hz = /bits/ 64 <1104000000>;
+		opp-microvolt = <1320000>;
+		clock-latency-ns = <244144>; /* 8 32k periods */
+	};
+
+	opp at 1200000000 {
+		opp-hz = /bits/ 64 <1200000000>;
+		opp-microvolt = <1320000>;
+		clock-latency-ns = <244144>; /* 8 32k periods */
+	};
+};
+
 &de {
 	status = "okay";
 };
-- 
2.9.3
