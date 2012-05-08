From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 8 May 2012 18:37:27 +0200
Subject: [PATCH 3/3] arm/dts: omap4-panda: Add LEDs support
In-Reply-To: <1336495047-5882-1-git-send-email-b-cousson@ti.com>
References: <1336495047-5882-1-git-send-email-b-cousson@ti.com>
Message-ID: <1336495047-5882-4-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the debug LEDs nodes for an OMAP4 PandaBoard.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index ea6f5bb..e671361 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -17,6 +17,21 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		heartbeat {
+			label = "pandaboard::status1";
+			gpios = <&gpio1 7 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		mmc {
+			label = "pandaboard::status2";
+			gpios = <&gpio1 8 0>;
+			linux,default-trigger = "mmc0";
+		};
+	};
 };
 
 &i2c1 {
-- 
1.7.0.4
