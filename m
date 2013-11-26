From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 16:47:11 +0900
Subject: [PATCH v2 2/3] ARM: shmobile: r8a7779: add HSPI support to DTSI
In-Reply-To: <1385452032-11544-1-git-send-email-horms+renesas@verge.net.au>
References: <1385452032-11544-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1385452032-11544-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on work for the r8a7778 SoC by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index b2b418a..7af0828 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -42,6 +42,12 @@
 		};
 	};
 
+	aliases {
+		spi0 = &hspi0;
+		spi1 = &hspi1;
+		spi2 = &hspi2;
+	};
+
         gic: interrupt-controller at f0001000 {
                 compatible = "arm,cortex-a9-gic";
                 #interrupt-cells = <3>;
@@ -248,4 +254,28 @@
 		cap-sdio-irq;
 		status = "disabled";
 	};
+
+	hspi0: spi at fffc7000 {
+		compatible = "renesas,hspi";
+		reg = <0xfffc7000 0x18>;
+		interrupt-controller = <&gic>;
+		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	hspi1: spi at fffc8000 {
+		compatible = "renesas,hspi";
+		reg = <0xfffc8000 0x18>;
+		interrupt-controller = <&gic>;
+		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	hspi2: spi at fffc6000 {
+		compatible = "renesas,hspi";
+		reg = <0xfffc6000 0x18>;
+		interrupt-controller = <&gic>;
+		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
 };
-- 
1.8.4
