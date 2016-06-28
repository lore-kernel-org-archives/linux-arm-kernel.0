From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 28 Jun 2016 12:51:21 +0800
Subject: [PATCH v1 4/5] ARM: dts: rockchip: add the panel power supply for
 rk3288-evb board with act8846 pmu
In-Reply-To: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
References: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1467089481-18713-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Panel regulator is controller by a normal GPIO, so we need to
write a regulator-fixed node for it.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index 452ca24..041dd5d 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -206,6 +206,10 @@
 	};
 };
 
+&panel {
+	power-supply = <&vcc_lcd>;
+};
+
 &pinctrl {
 	lcd {
 		lcd_en: lcd-en  {
-- 
1.9.1
