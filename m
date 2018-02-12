From: joel@jms.id.au (Joel Stanley)
Date: Mon, 12 Feb 2018 18:13:25 +1030
Subject: [PATCH 6/6] ARM: dts: aspeed: Add Palmetto GPIO hogs
In-Reply-To: <20180212074325.23436-1-joel@jms.id.au>
References: <20180212074325.23436-1-joel@jms.id.au>
Message-ID: <20180212074325.23436-7-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These hogs are for parts of the system that need to be in this state,
but do not yet have a driver associated with them but they must be
configured in order to successfully boot the host.

There are also some pinmux hogs, where the default mode of the IP block
is configured.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 157 ++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index 2a4a355a779d..bbddfe1d1cc8 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -74,6 +74,14 @@
 	};
 };
 
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flbusy_default &pinctrl_flwp_default
+
+			&pinctrl_vgahs_default &pinctrl_vgavs_default
+			&pinctrl_ddcclk_default &pinctrl_ddcdat_default>;
+};
+
 &uart5 {
 	status = "okay";
 };
@@ -142,3 +150,152 @@
 &ibt {
 	status = "okay";
 };
+
+&gpio {
+	pin_func_mode0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(C, 4) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "func_mode0";
+	};
+
+	pin_func_mode1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(C, 5)  GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "func_mode1";
+	};
+
+	pin_func_mode2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(C, 6) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "func_mode2";
+	};
+
+	pin_gpio_a0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(A, 0) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_FAN_RESERVED_N";
+	};
+
+	pin_gpio_a1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(A, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "APSS_WDT_N";
+	};
+
+	pin_gpio_b1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(B, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "APSS_BOOT_MODE";
+	};
+
+	pin_gpio_b2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "APSS_RESET_N";
+	};
+
+	pin_gpio_b7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(B, 7) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "SPIVID_STBY_RESET_N";
+	};
+
+	pin_gpio_d1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(D, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_POWER_UP";
+	};
+
+	pin_gpio_f1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_BATTERY_TEST";
+	};
+
+	pin_gpio_f4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 4) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "AST_HW_FAULT_N";
+	};
+
+	pin_gpio_f5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 5) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "AST_SYS_FAULT_N";
+	};
+
+	pin_gpio_f7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_FULL_SPEED_N";
+	};
+
+	pin_gpio_g3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 3) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_FAN_ERROR_N";
+	};
+
+	pin_gpio_g4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 4) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_WDT_RST1_P";
+	};
+
+	pin_gpio_g5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 5) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_WDT_RST2_P";
+	};
+
+	pin_gpio_h0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 0) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PE_SLOT_TEST_EN_N";
+	};
+
+	pin_gpio_h1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_RTCRST_N";
+	};
+
+	pin_gpio_h2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "SYS_PWROK_BMC";
+	};
+
+	pin_gpio_h6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "SCM1_FSI0_DATA_EN";
+	};
+
+	pin_gpio_h7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_TPM_INT_N";
+	};
+};
-- 
2.15.1
