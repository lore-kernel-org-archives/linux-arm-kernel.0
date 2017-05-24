From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Thu, 25 May 2017 00:24:32 +0300
Subject: [PATCH v2 1/2] ARM: dts: orange-pi-zero: specify wifi interrupts
In-Reply-To: <20170524212433.14386-1-geomatsi@gmail.com>
References: <20170524212433.14386-1-geomatsi@gmail.com>
Message-ID: <20170524212433.14386-2-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The orange-pi-zero board has Allwinner XR819 SDIO wifi chip. The board
dts file provides a node enabling mmc1 controller. Together with an
out-of-tree driver https://github.com/fifteenhex/xradio this node
enables using the wifi chip.

This commit specifies XR819 interrupt configuration for the driver.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 9e8b082c134f..e97dfd1775d1 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -128,6 +128,9 @@
 	 */
 	xr819: sdio_wifi at 1 {
 		reg = <1>;
+		compatible = "xradio,xr819";
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_EDGE_RISING>;
 	};
 };
 
-- 
2.11.0
