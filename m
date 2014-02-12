From: rogerq@ti.com (Roger Quadros)
Date: Wed, 12 Feb 2014 12:18:48 +0200
Subject: [PATCH v7 07/12] ARM: dts: omap5: Update omap-usb-host node
In-Reply-To: <1392200333-28397-1-git-send-email-rogerq@ti.com>
References: <1392200333-28397-1-git-send-email-rogerq@ti.com>
Message-ID: <1392200333-28397-8-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap-usb-host driver expects a certain name for internal
and external reference clocks. Provide these clocks.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a..d4dae48 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -775,6 +775,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			clocks = <&l3init_60m_fclk>,
+				 <&xclk60mhsp1_ck>,
+				 <&xclk60mhsp2_ck>;
+			clock-names = "refclk_60m_int",
+				      "refclk_60m_ext_p1",
+				      "refclk_60m_ext_p2";
 
 			usbhsohci: ohci at 4a064800 {
 				compatible = "ti,ohci-omap3", "usb-ohci";
-- 
1.8.3.2
