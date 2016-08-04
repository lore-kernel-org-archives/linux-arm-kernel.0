From: anurupvasu@gmail.com (Anurup M)
Date: Thu,  4 Aug 2016 05:07:14 -0400
Subject: [RFC PATCH v1 10/10] 	arm64: dts: hip05: Add L3 cache PMU support
In-Reply-To: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
References: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1470301634-79736-11-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Add nodes for hip05 L3 cache.
	2. Add djtag node and sysctrl node for hip05.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 4af2c72..0fd7e23 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -749,6 +749,25 @@
 			status = "disabled";
 		};
 
+		pc_sysctrl0: system-controller at 0x80010000 {
+			compatible = "hisilicon,hip05-sysctrl", "syscon";
+			reg = <0x0 0x80010000 0x0 0x10000>;
+		};
+
+		djtag0: djtag {
+			compatible = "hisilicon,hip05-cpu-djtag-v1";
+			syscon = <&pc_sysctrl0>;
+		};
+
+		l3c0: l3c {
+			compatible = "hisilicon,hip05-l3c";
+			djtag = <&djtag0 2>;
+			interrupt-parent = <&mbigen_pc>;
+			interrupts = <141 4>,<142 4>,
+				<143 4>,<144 4>;
+			status = "okay";
+		};
+
 		pcie0: pcie at b0080000 {
 			compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
 			reg = <0 0xb0080000 0 0x10000>, <0x220 0x04000000 0 0x04000000>;
-- 
2.1.4
