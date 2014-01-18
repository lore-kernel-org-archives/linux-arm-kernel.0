From: kasimling@gmail.com (Alex Ling)
Date: Sat, 18 Jan 2014 22:24:43 +0800
Subject: [PATCH 2/2] ARM: dts: Add AT24C08 EEPROM support to TINY4412
In-Reply-To: <1390055084-27483-1-git-send-email-kasimling@gmail.com>
References: <1390055084-27483-1-git-send-email-kasimling@gmail.com>
Message-ID: <1390055084-27483-2-git-send-email-kasimling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for AT24C08 EEPROM found on TINY4412 board.

Signed-off-by: Alex Ling <kasimling@gmail.com>
---
 arch/arm/boot/dts/exynos4412-tiny4412.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 2c6bfe3..9f63664 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -109,4 +109,16 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	i2c at 13860000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <200000>;
+
+		eeprom at 50 {
+			compatible = "atmel,24c08";
+			reg = <0x50>;
+			pagesize = <16>;
+		};
+	};
 };
-- 
1.7.9.5
