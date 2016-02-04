From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:28:55 +0100
Subject: [PATCH 01/70] ARM: dts: gose: Add GPIO keys to DT
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <d7d5974b156e2ef7436483de00ccada5987c9d31.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate the GPIO keys in the gose device tree.

Based on similar work for the koelsch board by Laurent Pinchart.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Tested-by: Magnus Damm <damm+renesas@opensource.se>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 82 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index baa59fe84298..ccbc1c66cc6c 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -31,6 +31,88 @@
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x40000000>;
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-1 {
+		        gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_1>;
+		        label = "SW2-1";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-2 {
+		        gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_2>;
+		        label = "SW2-2";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-3 {
+		        gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_3>;
+		        label = "SW2-3";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-4 {
+		        gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_4>;
+		        label = "SW2-4";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-a {
+		        gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_A>;
+		        label = "SW30";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-b {
+		        gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_B>;
+		        label = "SW31";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-c {
+		        gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_C>;
+		        label = "SW32";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-d {
+		        gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_D>;
+		        label = "SW33";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-e {
+		        gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_E>;
+		        label = "SW34";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-f {
+		        gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_F>;
+		        label = "SW35";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+		key-g {
+		        gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+		        linux,code = <KEY_G>;
+		        label = "SW36";
+		        gpio-key,wakeup;
+		        debounce-interval = <20>;
+		};
+	};
 };
 
 &extal_clk {
-- 
2.7.0.rc3.207.g0ac5344
