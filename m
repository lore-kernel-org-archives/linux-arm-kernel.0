From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Sat, 20 May 2017 00:35:49 +0300
Subject: [PATCH 1/2] ARM: dts: orange-pi-zero: interrupt triggering for XR819
 WiFi chip
In-Reply-To: <20170519213550.8434-1-geomatsi@gmail.com>
References: <20170519213550.8434-1-geomatsi@gmail.com>
Message-ID: <20170519213550.8434-2-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify interrupt triggering for XR819 SDIO WiFi chip
on orange-pi-zero board.

For more details see: http://linux-sunxi.org/Wifi#Allwinner

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 9e8b082c134f..34e4a5a80136 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -128,6 +128,8 @@
 	 */
 	xr819: sdio_wifi at 1 {
 		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_EDGE_RISING>;
 	};
 };
 
-- 
2.11.0
