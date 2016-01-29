From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 29 Jan 2016 16:39:05 +0800
Subject: [PATCH 5/6] arm64: dts: hip05: Append power button node for D02 board
In-Reply-To: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1454056746-5048-6-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds poweroff button device node to support
poweroff feature on hip05 d02 board.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
index ae34e25..e9436c0 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "hip05.dtsi"
 
 / {
@@ -29,8 +30,25 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pwrbutton {
+			label = "Power Button";
+			gpios = <&porta 8 GPIO_ACTIVE_LOW>;
+			linux,code = <116>;
+			debounce-interval = <0>;
+		};
+	};
 };
 
 &uart0 {
 	status = "ok";
 };
+
+&peri_gpio0 {
+	status = "ok";
+};
-- 
2.6.0.GIT
