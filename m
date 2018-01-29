From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Jan 2018 19:21:20 +0100
Subject: [PATCH 1/2] arm64: dts: r8a7796: Update OPPs to support CA53 dfs
In-Reply-To: <20180129182121.833-1-horms+renesas@verge.net.au>
References: <20180129182121.833-1-horms+renesas@verge.net.au>
Message-ID: <20180129182121.833-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dien Pham <dien.pham.ry@renesas.com>

Describe frequencies, other than the default for CA53 cores.  This is a
pre-requisite for using providing alternative frequencies for use with
CPUFreq with these cores.

Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index f8e9313f9405..0c7ad930aebf 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -204,11 +204,27 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
 	};
 
 	/* External PCIe clock - can be overridden by the board */
-- 
2.11.0
