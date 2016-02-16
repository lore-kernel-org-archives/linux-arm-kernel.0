From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed, 17 Feb 2016 01:08:48 +0800
Subject: [PATCH v13 2/4] ARM64: add SBSA Generic Watchdog device node in
 foundation-v8.dts
In-Reply-To: <1455642530-19103-1-git-send-email-fu.wei@linaro.org>
References: <1455642530-19103-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1455642530-19103-3-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This can be a example of adding SBSA Generic Watchdog device node
into some dts files for the Soc which contains SBSA Generic Watchdog.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/boot/dts/arm/foundation-v8.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index 4eac8dc..66cb9aa 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -237,4 +237,11 @@
 			};
 		};
 	};
+	watchdog at 2a440000 {
+		compatible = "arm,sbsa-gwdt";
+		reg = <0x0 0x2a440000 0 0x1000>,
+			<0x0 0x2a450000 0 0x1000>;
+		interrupts = <0 27 4>;
+		timeout-sec = <30>;
+	};
 };
-- 
2.5.0
