From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 22 Dec 2015 17:19:49 +0800
Subject: [PATCH v1 6/6] ARM64: dts: rockchip: add reboot-mode node
In-Reply-To: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1450775989-24301-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reboot mode driver DT node for rk3368 platform

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v1: None

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index cc093a4..776f1be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 
 / {
 	compatible = "rockchip,rk3368";
@@ -202,6 +203,31 @@
 		method = "smc";
 	};
 
+	reboot_mode {
+		compatible = "rockchip,reboot-mode";
+		rockchip,regmap = <&pmugrf>;
+		offset = <0x200>;
+		loader {
+			linux,mode = "loader";
+			linux,magic = <BOOT_LOADER>;
+		};
+
+		maskrom {
+			linux,mode = "maskrom";
+			linux,magic = <BOOT_MASKROM>;
+		};
+
+		recovery {
+			linux,mode = "recovery";
+			linux,magic = <BOOT_RECOVERY>;
+		};
+
+		fastboot {
+			linux,mode = "fastboot";
+			linux,magic = <BOOT_FASTBOOT>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
1.9.1
