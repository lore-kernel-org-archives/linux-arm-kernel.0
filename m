From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 28 Aug 2014 13:34:17 +0800
Subject: [PATCH v2 3/6] ARM: dts: hix5hd2: add usb node
In-Reply-To: <1409204060-9223-1-git-send-email-zhangfei.gao@linaro.org>
References: <1409204060-9223-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1409204060-9223-4-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 802331b..9252264 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -199,5 +199,19 @@
 			clocks = <&clock HIX5HD2_MAC1_CLK>;
 			status = "disabled";
 		};
+
+		usb0: ehci at 1890000 {
+		        compatible = "generic-ehci";
+			reg = <0x1890000 0x1000>;
+			interrupts = <0 66 4>;
+			clocks = <&clock HIX5HD2_USB_CLK>;
+	        };
+
+		usb1: ohci at 1880000 {
+			compatible = "generic-ohci";
+			reg = <0x1880000 0x1000>;
+			interrupts = <0 67 4>;
+			clocks = <&clock HIX5HD2_USB_CLK>;
+		};
 	};
 };
-- 
1.7.9.5
