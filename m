From: briannorris@chromium.org (Brian Norris)
Date: Thu,  1 Dec 2016 18:27:29 -0800
Subject: [PATCH 5/9] arm64: dts: rockchip: add rk3399 OPPs
In-Reply-To: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
Message-ID: <1480645653-36943-6-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used for Gru/Kevin, but they should be conservative enough for all
boards. (And ideally, any board-to-board differences can be represented
via, e.g., describing regulator offsets.)

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi | 145 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi     |   1 +
 2 files changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
new file mode 100644
index 000000000000..e1038cd92ce5
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
@@ -0,0 +1,145 @@
+/*
+ * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/ {
+	cluster0_opp: opp-table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <40000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <800000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <800000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <875000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <925000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1050000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt = <1125000>;
+		};
+	};
+
+	cluster1_opp: opp-table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <40000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <800000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <825000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <875000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <950000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <1075000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1150000>;
+		};
+		opp08 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <1250000>;
+		};
+	};
+};
+
+&cpu_l0 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_l1 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_l2 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_l3 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_b0 {
+	operating-points-v2 = <&cluster1_opp>;
+};
+
+&cpu_b1 {
+	operating-points-v2 = <&cluster1_opp>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 1e97fb8c6415..02392c084607 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1948,3 +1948,4 @@
 
 	};
 };
+#include "rk3399-opp.dtsi"
-- 
2.8.0.rc3.226.g39d4020
