From: daniel@zonque.org (Daniel Mack)
Date: Wed, 16 May 2018 14:28:29 +0200
Subject: [PATCH 3/3] ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup source
In-Reply-To: <20180516122829.23694-1-daniel@zonque.org>
References: <20180516122829.23694-1-daniel@zonque.org>
Message-ID: <20180516122829.23694-4-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The touchscreen driver no longer configures the device as wakeup source by
default. A "wakeup-source" property is needed.

To avoid regressions, this patch changes the DTS files for the only two
users of this driver that didn't have this property yet.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/imx28-tx28.dts      | 1 +
 arch/arm/boot/dts/imx53-tx53-x03x.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 0ebbc83852d0..094a39a67ec8 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -328,6 +328,7 @@
 		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 	};
 
 	touchscreen: tsc2007 at 48 {
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 0ecb43d88522..dbf0d73dc7b9 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -220,6 +220,7 @@
 		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 	};
 
 	touchscreen: tsc2007 at 48 {
-- 
2.14.3
