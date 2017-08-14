From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 14 Aug 2017 16:44:11 +0800
Subject: [PATCH v4 8/8] ARM: dts: rockchip: add accelerometer bma250e dt node
 for rv1108 evb
In-Reply-To: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
References: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1502700251-8852-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt node of bosch accelerometer bma250e on rv1108 evb.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v4:
- order it by i2c address.

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rv1108-evb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index a1bd95e..32fb09a 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -202,6 +202,13 @@
 			};
 		};
 	};
+
+	bma250: accelerometer at 19 {
+		compatible = "bosch,bma250e";
+		reg = <0x19>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB3 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
 
 &pwm0 {
-- 
2.7.4
