From: yvo@apm.com (Y Vo)
Date: Fri, 26 Jun 2015 15:01:47 +0700
Subject: [PATCH v1] arm64: dts: Add poweroff button device node for APM X-Gene
 platform
In-Reply-To: <1435305707-22786-1-git-send-email-yvo@apm.com>
References: <1435305707-22786-1-git-send-email-yvo@apm.com>
Message-ID: <1435305707-22786-2-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds poweroff button device node to support poweroff feature
on APM X-Gene Mustang platform.

Signed-off-by: Y Vo <yvo@apm.com>
---
 arch/arm64/boot/dts/apm/apm-mustang.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index 83578e7..4c55833 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -23,6 +23,16 @@
 		device_type = "memory";
 		reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		button at 1 {
+			label = "POWER";
+			linux,code = <116>;
+			linux,input-type = <0x1>;
+			interrupts = <0x0 0x2d 0x1>;
+		};
+	};
 };
 
 &pcie0clk {
-- 
1.7.1
