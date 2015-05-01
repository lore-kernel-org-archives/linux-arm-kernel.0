From: ttnguyen@apm.com (Tai Nguyen)
Date: Fri,  1 May 2015 13:11:14 -0700
Subject: [PATCH 2/2] power: reset: Add syscon poweroff device node for APM
 X-Gene platform
In-Reply-To: <1430511074-32229-1-git-send-email-ttnguyen@apm.com>
References: <1430511074-32229-1-git-send-email-ttnguyen@apm.com>
Message-ID: <1430511074-32229-3-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds syscon poweroff device node to support poweroff feature
on APM X-Gene Mustang platform

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---
 arch/arm64/boot/dts/apm/apm-mustang.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index 83578e7..910d561 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -23,6 +23,18 @@
 		device_type = "memory";
 		reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
 	};
+
+	poweroff_mbox: poweroff_mbox at 10548000 {
+		compatible = "syscon";
+		reg = <0x0 0x10548000 0x0 0x30>;
+	};
+
+	poweroff: poweroff at 10548010 {
+		compatible = "syscon-poweroff";
+		regmap = <&poweroff_mbox>;
+		offset = <0x10>;
+		mask = <0x1>;
+	};
 };
 
 &pcie0clk {
-- 
1.7.9.5
