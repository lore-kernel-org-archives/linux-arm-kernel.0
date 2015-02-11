From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 12 Feb 2015 01:06:49 +0300
Subject: [PATCH] ARM: shmobile: r8a7794: add PFC DT support
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Message-ID: <5570320.hDPc0mxmnU@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7794 part of the PFC device node.

Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20150211-v3.19' tag of Simon Horman's
'renesas.git' repo. It needs the R8A7794 PFC driver patch in order to work.

 arch/arm/boot/dts/r8a7794.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -107,6 +107,12 @@
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
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
