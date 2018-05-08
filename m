From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 8 May 2018 19:39:40 +0300
Subject: [PATCH] arm64: dts: renesas: r8a77970: add SMP support
In-Reply-To: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
Message-ID: <54dbd1d2-8279-5073-cffb-c647fba91e42@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device node for the second Cortex-A53 CPU core.

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20180508-v4.17-rc4' tag of Simon
Horman's 'renesas.git' repo.

 arch/arm64/boot/dts/renesas/r8a77970.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -41,6 +41,16 @@
 			enable-method = "psci";
 		};
 
+		a53_1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <1>;
+			clocks = <&cpg CPG_CORE R8A77970_CLK_Z2>;
+			power-domains = <&sysc R8A77970_PD_CA53_CPU1>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
 		L2_CA53: cache-controller {
 			compatible = "cache";
 			power-domains = <&sysc R8A77970_PD_CA53_SCU>;
