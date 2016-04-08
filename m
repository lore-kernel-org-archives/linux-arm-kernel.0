From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 8 Apr 2016 15:31:50 +0800
Subject: [PATCH v2 1/2] arm64: dts: hip05: fix its node without msi-cells
In-Reply-To: <1460100711-54144-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460100711-54144-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1460100711-54144-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix commit abf9c25d55e8 ("arm64: dts: hip05: Append all gicv3 ITS
entries"), it forgets the property msi-cell, see arm,gic-v3.txt.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 6319ff3..52d06ab 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -249,24 +249,28 @@
 		its_peri: interrupt-controller at 8c000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0x8c000000 0x0 0x40000>;
 		};
 
 		its_m3: interrupt-controller at a3000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0xa3000000 0x0 0x40000>;
 		};
 
 		its_pcie: interrupt-controller at b7000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0xb7000000 0x0 0x40000>;
 		};
 
 		its_dsa: interrupt-controller at c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0xc6000000 0x0 0x40000>;
 		};
 	};
-- 
1.7.12.4
