From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Aug 2015 11:11:30 +0900
Subject: [PATCH 06/10] ARM: shmobile: r8a7794: add MMCIF DT support
In-Reply-To: <cover.1438911334.git.horms+renesas@verge.net.au>
References: <cover.1438911334.git.horms+renesas@verge.net.au>
Message-ID: <6cdf6ba19c8b9a386ef882206b29d97a49271317.1438911334.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7794 part of the MMCIF0 device node.

Based on the orginal patch by Shinobu Uehara <shinobu.uehara.xc@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 51cc2b975c3f..43acf185ecc4 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
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
-- 
2.1.4
