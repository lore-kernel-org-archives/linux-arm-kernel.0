From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 21 Jan 2013 02:39:15 -0800
Subject: [PATCH] ARM: dts: add mshc controller node for Exynos4x12 SoCs
Message-ID: <1358764755-21470-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit cea0f256 ("ARM: dts: Add board dts file for ODROID-X") includes a node
to describe the board level properties for mshc controller. But the mshc
controller node was not added in the Exynos4x12 dtsi file which resulted
in the following warning when compiling the dtb files.

Warning (reg_format): "reg" property in /mshc at 12550000/slot at 0 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /mshc at 12550000/slot at 0
Warning (avoid_default_addr_size): Relying on default #size-cells value for /mshc at 12550000/slot at 0

Fix this by adding the mshc controller node for Exynos4x12 SoCs.

Cc: Dongjin Kim <tobetter@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4412.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 78ed377..96f5b66 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -32,4 +32,12 @@
 		interrupts = <0 57 0>, <0 0 0>, <0 0 0>, <0 0 0>,
 			     <1 12 0>, <1 12 0>, <1 12 0>, <1 12 0>;
 	};
+
+	mshc at 12550000 {
+		compatible = "samsung,exynos4412-dw-mshc";
+		reg = <0x12550000 0x1000>;
+		interrupts = <0 77 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
-- 
1.7.5.4
