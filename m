From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:48 +0900
Subject: [PATCH 14/69] ARM: shmobile: r8a7778: add SDHI support on DTSI
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <04cbd88902dd16a8f20db808ab444035be2557ac.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 0ff38e6..873eeb9 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -164,4 +164,34 @@
 		interrupts = <0 61 4>;
 		status = "disabled";
 	};
+
+	sdhi0: sdhi at ffe4c000 {
+		compatible = "renesas,sdhi-r8a7778";
+		reg = <0xffe4c000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 87 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
+	sdhi1: sdhi at ffe4d000 {
+		compatible = "renesas,sdhi-r8a7778";
+		reg = <0xffe4d000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 88 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
+	sdhi2: sdhi at ffe4f000 {
+		compatible = "renesas,sdhi-r8a7778";
+		reg = <0xffe4f000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 86 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
 };
-- 
1.8.4
