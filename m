From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 18 Nov 2015 14:20:34 -0800
Subject: [PATCH 1/2] ARM: shmobile: gose: Add GPIO keys to DT
In-Reply-To: <1447885235-17858-1-git-send-email-horms+renesas@verge.net.au>
References: <1447885235-17858-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1447885235-17858-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate the GPIO keys in the gose device tree.

Based on similar work for the koelsch board by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
* Compile Tested Only
---
 arch/arm/boot/dts/r8a7793-gose.dts | 82 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index d842ce77b7c8..ff391d2fb767 100644
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
2.1.4
