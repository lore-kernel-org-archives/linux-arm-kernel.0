From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 29 Jan 2016 16:39:03 +0800
Subject: [PATCH 3/6] arm64: dts: hip05: Append all gicv3 ITS entries
In-Reply-To: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1454056746-5048-4-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are four subsystems in hip05 soc, peri/m3/pcie/dsa,
each subsystem has one its, append them under gicv3 node.

They will be used by hisilicon mbigen.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index ed31f19..c1b1a32 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -246,11 +246,29 @@
 		      <0x0 0xfe020000 0 0x10000>;       /* GICV */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-		its_totems: interrupt-controller at 8c000000 {
+		its_peri: interrupt-controller at 8c000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			reg = <0x0 0x8c000000 0x0 0x40000>;
 		};
+
+		its_m3: interrupt-controller at a3000000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0xa3000000 0x0 0x40000>;
+		};
+
+		its_pcie: interrupt-controller at b7000000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0xb7000000 0x0 0x40000>;
+		};
+
+		its_dsa: interrupt-controller at c6000000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0xc6000000 0x0 0x40000>;
+		};
 	};
 
 	timer {
-- 
2.6.0.GIT
