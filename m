From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 31 Jul 2015 00:54:05 +0300
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7794: add MMCIF DT support
In-Reply-To: <1546028.CFITDbxXtD@wasted.cogentembedded.com>
References: <1546028.CFITDbxXtD@wasted.cogentembedded.com>
Message-ID: <2274701.D1UH0V9VRM@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7794 part of the MMCIF0 device node.

Based on the orginal patch by Shinobu Uehara <shinobu.uehara.xc@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version  2:
- updated the patch due to the SDHI patch being accepted first;
- refreshed the patch.

 arch/arm/boot/dts/r8a7794.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -383,6 +383,17 @@
 		status = "disabled";
 	};
 
+	mmcif0: mmc at ee200000 {
+		compatible = "renesas,mmcif-r8a7794", "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7794_CLK_MMCIF0>;
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
+		dma-names = "tx", "rx";
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7794";
 		reg = <0 0xee100000 0 0x200>;
