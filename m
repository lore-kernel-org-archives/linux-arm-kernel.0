From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Thu, 31 May 2018 11:27:51 +0800
Subject: [PATCH v3 3/5] arm64: dts: rockchip: Add GPIO_MUTE pin support to
 rk3328
In-Reply-To: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
References: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <1527737273-8387-4-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>

Adding a new gpio controller named "gpio_mute" to rk3328, providing
access to the GPIO_MUTE pin, which is manupulated by the GRF_SOC_CON10
register.

The GPIO_MUTE pin is referred to as <&gpio_mute 0>.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v3:
- Use dedicated "rockchip,rk3328-gpio-mute" driver

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in rk3328.dtsi

Changes in v1:
- Split from V0 and add to rk3328.dtsi for general use.

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index be2bfbc..2ee0fa3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -309,6 +309,13 @@
 			mode-loader = <BOOT_BL_DOWNLOAD>;
 		};
 
+		/* Use <&gpio_mute 0> to refer to GPIO_MUTE pin */
+		gpio_mute: gpio-mute {
+			compatible = "rockchip,rk3328-gpio-mute";
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+		};
 	};
 
 	uart0: serial at ff110000 {
-- 
2.7.4
