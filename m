From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 28 Jun 2016 12:51:24 +0800
Subject: [PATCH v1 5/5] ARM: dts: rockchip: add the panel power supply for
 rk3288-evb board with rk808 pmu
In-Reply-To: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
References: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1467089484-18756-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Panel regulator is controller by a normal GPIO, so we need to
write a regulator-fixed node for it.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-evb-rk808.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index 736b08b..44ebc6e 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -233,3 +233,7 @@
 		};
 	};
 };
+
+&panel {
+	power-supply = <&vcc_lcd>;
+};
-- 
1.9.1
