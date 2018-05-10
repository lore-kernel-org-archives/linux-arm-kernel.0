From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Thu, 10 May 2018 17:16:38 +0800
Subject: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
In-Reply-To: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>

Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
access to the pins defined in the syscon GRF_SOC_CON10.

Boards using these special pins to control regulators or LEDs, can now
utilize existing drivers like gpio-regulator and leds-gpio.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v1:
- Split from V0 and add to rk3328.dtsi for general use.

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b8e9da1..73a822d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -309,6 +309,12 @@
 			mode-loader = <BOOT_BL_DOWNLOAD>;
 		};
 
+		gpio_syscon10: gpio-syscon10 {
+			compatible = "rockchip,gpio-syscon";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <0 0x0428 0>;
+		};
 	};
 
 	uart0: serial at ff110000 {
-- 
2.7.4
