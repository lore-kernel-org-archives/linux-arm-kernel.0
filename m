From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:36:20 +0900
Subject: [PATCH 08/11] ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
In-Reply-To: <cover.1374478037.git.horms+renesas@verge.net.au>
References: <cover.1374478037.git.horms+renesas@verge.net.au>
Message-ID: <369ee2db438cc0adc6952b424743e9ed21a0edee.1374478037.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This adds DT templates for all MMCIF and SDHI controllers on r8a73a4.
They are added with status="disabled". To use them platform-specific
DTs have to enable the required ones.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 4e1ddf0..6ce699b 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -166,4 +166,49 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 173 0x4>;
 	};
+
+	mmcif0: mmcif at ee200000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 169 0x4>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	mmcif1: mmcif at ee220000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0 0xee220000 0 0x80>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 170 0x4>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	sdhi0: sdhi at ee100000 {
+		compatible = "renesas,r8a73a4-sdhi";
+		reg = <0 0xee100000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 165 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	sdhi1: sdhi at ee120000 {
+		compatible = "renesas,r8a73a4-sdhi";
+		reg = <0 0xee120000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 166 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	sdhi2: sdhi at ee140000 {
+		compatible = "renesas,r8a73a4-sdhi";
+		reg = <0 0xee140000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 167 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
 };
-- 
1.8.2.1
