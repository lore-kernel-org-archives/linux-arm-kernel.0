From: aford173@gmail.com (Adam Ford)
Date: Sun, 24 Jun 2018 19:12:32 -0500
Subject: [RFC 4/5] ARM: dts: AM35x: Change MUSB from omap2430 to am35xx
In-Reply-To: <20180625001233.9785-1-aford173@gmail.com>
References: <20180625001233.9785-1-aford173@gmail.com>
Message-ID: <20180625001233.9785-5-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The glue that connects the AM35xx is not the same as the OMAP3.
With the AM35xx-MUSB now available in device tree, point to that
glue instead of omap3.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index ca294914bbb1..c17cfe6a2132 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -18,7 +18,7 @@
 
 	ocp at 68000000 {
 		am35x_otg_hs: am35x_otg_hs at 5c040000 {
-			compatible = "ti,omap3-musb";
+			compatible = "ti,am35xx-musb";
 			ti,hwmods = "am35x_otg_hs";
 			status = "disabled";
 			reg = <0x5c040000 0x1000>;
-- 
2.17.1
