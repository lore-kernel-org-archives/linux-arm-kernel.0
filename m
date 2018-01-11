From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 11 Jan 2018 22:53:55 +0100
Subject: [PATCH] ARM: dts: sun8i: acivate SPI on Orange Pi R1
Message-ID: <20180111215355.22182-1-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has a SPI flash, activate it also in device tree by default.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
index 112f09c67d67..3356f4210d45 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
@@ -68,6 +68,14 @@
 	};
 };
 
+&spi0 {
+	status = "okay";
+
+	flash at 0 {
+		compatible = "mxicy,mx25l12805d", "jedec,spi-nor";
+	};
+};
+
 &ohci1 {
 	/*
 	 * RTL8152B USB-Ethernet adapter is connected to USB1,
-- 
2.11.0
