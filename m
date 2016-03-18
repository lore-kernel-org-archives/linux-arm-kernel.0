From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Mar 2016 02:40:01 +0100
Subject: [PATCH 05/10] ARM: dts: rockchip: add core rk3288-veyron backlight
 and panel nodes
In-Reply-To: <1458265206-15733-1-git-send-email-heiko@sntech.de>
References: <1458265206-15733-1-git-send-email-heiko@sntech.de>
Message-ID: <1458265206-15733-6-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many Veyron chromebooks share the same panel type, so define the core
settings for all of them and allow the few runaways to override it later.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index 610769d..7563d3d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -54,6 +54,50 @@
 		i2c20 = &i2c_tunnel;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <
+			  0   1   2   3   4   5   6   7
+			  8   9  10  11  12  13  14  15
+			 16  17  18  19  20  21  22  23
+			 24  25  26  27  28  29  30  31
+			 32  33  34  35  36  37  38  39
+			 40  41  42  43  44  45  46  47
+			 48  49  50  51  52  53  54  55
+			 56  57  58  59  60  61  62  63
+			 64  65  66  67  68  69  70  71
+			 72  73  74  75  76  77  78  79
+			 80  81  82  83  84  85  86  87
+			 88  89  90  91  92  93  94  95
+			 96  97  98  99 100 101 102 103
+			104 105 106 107 108 109 110 111
+			112 113 114 115 116 117 118 119
+			120 121 122 123 124 125 126 127
+			128 129 130 131 132 133 134 135
+			136 137 138 139 140 141 142 143
+			144 145 146 147 148 149 150 151
+			152 153 154 155 156 157 158 159
+			160 161 162 163 164 165 166 167
+			168 169 170 171 172 173 174 175
+			176 177 178 179 180 181 182 183
+			184 185 186 187 188 189 190 191
+			192 193 194 195 196 197 198 199
+			200 201 202 203 204 205 206 207
+			208 209 210 211 212 213 214 215
+			216 217 218 219 220 221 222 223
+			224 225 226 227 228 229 230 231
+			232 233 234 235 236 237 238 239
+			240 241 242 243 244 245 246 247
+			248 249 250 251 252 253 254 255>;
+		default-brightness-level = <128>;
+		enable-gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
+		backlight-boot-off;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en>;
+		pwms = <&pwm0 0 1000000 0>;
+		pwm-delay-us = <10000>;
+	};
+
 	gpio-charger {
 		compatible = "gpio-charger";
 		charger-type = "mains";
@@ -62,6 +106,13 @@
 		pinctrl-0 = <&ac_present_ap>;
 	};
 
+	panel: panel {
+		compatible ="innolux,n116bge", "simple-panel";
+		status = "okay";
+		power-supply = <&vcc33_lcd>;
+		backlight = <&backlight>;
+	};
+
 	/* A non-regulated voltage from power supply or battery */
 	vccsys: vccsys {
 		compatible = "regulator-fixed";
@@ -184,6 +235,12 @@
 		&suspend_l_sleep
 	>;
 
+	backlight {
+		bl_en: bl-en {
+			rockchip,pins = <7 2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	buttons {
 		ap_lid_int_l: ap-lid-int-l {
 			rockchip,pins = <0 6 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.6.4
