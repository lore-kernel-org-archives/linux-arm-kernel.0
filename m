From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 28 Jul 2015 01:29:31 +0300
Subject: [PATCH v2] ARM: shmobile: r8a7794: add PFC DT support
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Message-ID: <1878107.PNh5nFF1p8@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7794 part of the PFC device node.

Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20150727-v4.2-rc4' tag of Simon Horman's
'renesas.git' repo.

Changes in version 2:
- refreshed the patch.

 arch/arm/boot/dts/r8a7794.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -108,6 +108,12 @@
 		clocks = <&mstp4_clks R8A7794_CLK_IRQC>;
 	};
 
+	pfc: pin-controller at e6060000 {
+		compatible = "renesas,pfc-r8a7794";
+		reg = <0 0xe6060000 0 0x11c>;
+		#gpio-range-cells = <3>;
+	};
+
 	dmac0: dma-controller at e6700000 {
 		compatible = "renesas,rcar-dmac";
 		reg = <0 0xe6700000 0 0x20000>;
