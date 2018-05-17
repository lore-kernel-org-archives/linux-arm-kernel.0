From: manu@freebsd.org (Emmanuel Vadot)
Date: Thu, 17 May 2018 17:06:13 +0200
Subject: [PATCH] ARM64: dts: sun50i: a64: Add spi flash node for sopine
Message-ID: <20180517150613.11916-1-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Sopine and Pine64-LTS have a winbond w25q128 spi flash on spi0.
Add a node for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 43418bd881d8..3285aebc06d9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -66,6 +66,18 @@
 	};
 };
 
+&spi0  {
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 #include "axp803.dtsi"
 
 &reg_aldo2 {
-- 
2.17.0
