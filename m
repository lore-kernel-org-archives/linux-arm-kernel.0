From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 16:13:23 +0800
Subject: [PATCH 5/7] arm64: dts: hikey960: Add support for syscon-reboot-mode
In-Reply-To: <20170807081325.11406-1-guodong.xu@linaro.org>
References: <20170807081325.11406-1-guodong.xu@linaro.org>
Message-ID: <20170807081325.11406-6-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to hikey960 dts for the syscon-reboot-mode driver.

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index b96d865..ce5e874 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -39,6 +39,20 @@
 		reg = <0x0 0x0 0x0 0x0>;
 	};
 
+	reboot-mode-syscon at 32100000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x0 0x32100000 0x0 0x00001000>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x0>;
+
+			mode-normal	= <0x77665501>;
+			mode-bootloader	= <0x77665500>;
+			mode-recovery	= <0x77665502>;
+		};
+	};
+
 	keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
-- 
2.10.2
