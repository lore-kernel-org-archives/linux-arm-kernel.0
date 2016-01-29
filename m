From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 29 Jan 2016 16:39:04 +0800
Subject: [PATCH 4/6] arm64: dts: hip05: Append gpio nodes
In-Reply-To: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1454056746-5048-5-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two dw GPIO controllers in hip05 peri sub, this patch
adds the corresponding device tree nodes.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index c1b1a32..6319ff3 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -322,5 +322,43 @@
 			reg-io-width = <4>;
 			status = "disabled";
 		};
+
+		peri_gpio0: gpio at 802e0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x802e0000 0x0 0x10000>;
+			status = "disabled";
+
+			porta: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		peri_gpio1: gpio at 802f0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x802f0000 0x0 0x10000>;
+			status = "disabled";
+
+			portb: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
 	};
 };
-- 
2.6.0.GIT
