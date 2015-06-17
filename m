From: yvo@apm.com (Y Vo)
Date: Wed, 17 Jun 2015 08:41:52 +0700
Subject: [PATCH v0] arm64: dts: Add poweroff button device node for APM X-Gene
 platform
Message-ID: <1434505312-27977-1-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds poweroff button device node to support poweroff feature
on APM X-Gene Mustang platform.

Signed-off-by: Y Vo <yvo@apm.com>
---
 arch/arm64/boot/dts/apm/apm-mustang.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index 83578e7..67979c8 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -23,6 +23,17 @@
 		device_type = "memory";
 		reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		apm_ctrl_name = "Power Button";
+		btn3 {
+			label = "EXT_PWR";
+			linux,code = <116>;
+			linux,input-type = <0x1>;     /* EV_KEY */
+			interrupts = <0x0 0x2d 0x1>;
+		};
+	};
 };
 
 &pcie0clk {
-- 
1.7.1
