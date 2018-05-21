From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon, 21 May 2018 13:54:13 +0200
Subject: [PATCH v2] ARM64: dts: sun50i: a64: Add spi flash node for sopine
Message-ID: <20180521115413.92070-1-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Sopine and Pine64-LTS have a winbond w25q128 spi flash on spi0.
Add a node for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
Changes in v2:
 - Only use the compatible 'jedec,spi-nor' since the device answer to
 the jedec command 0x9F

 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 43418bd881d8..b94f93c04acb 100644
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
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 #include "axp803.dtsi"
 
 &reg_aldo2 {
-- 
2.17.0
