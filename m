From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Fri, 18 May 2018 11:52:06 +0800
Subject: [PATCH v2 3/5] arm64: dts: rockchip: Add gpio-mute to rk3328
In-Reply-To: <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <1526615528-9707-3-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>

Adding a new gpio controller named "gpio-mute" to rk3328, providing
access to the GPIO_MUTE pin defined in the syscon GRF_SOC_CON10.

The GPIO_MUTE pin is referred to as <&gpio-mute 1>.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in rk3328.dtsi

Changes in v1:
- Split from V0 and add to rk3328.dtsi for general use.

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b8e9da1..5ba29d3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -309,6 +309,13 @@
 			mode-loader = <BOOT_BL_DOWNLOAD>;
 		};
 
+		/* The GPIO_MUTE pin is referred to as <&gpio-mute 1>.*/
+		gpio_mute: gpio-mute {
+			compatible = "rockchip,gpio-syscon";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <0 0x0428 0>;
+		};
 	};
 
 	uart0: serial at ff110000 {
-- 
2.7.4
