From: w.f@huawei.com (Fei Wang)
Date: Wed, 30 Sep 2015 19:05:06 +0800
Subject: [PATCH 3/8] arm64: dts: add Hi655x pmic node
In-Reply-To: <1443611111-3196-1-git-send-email-w.f@huawei.com>
References: <1443611111-3196-1-git-send-email-w.f@huawei.com>
Message-ID: <1443611111-3196-4-git-send-email-w.f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add Hi655x device node for pmic in dts.

Signed-off-by: Fei Wang <w.f@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..4e4830b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -168,4 +168,13 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 	};
+
+	pmic: pmic at F8000000 {
+                compatible = "hisilicon,hi655x-pmic-driver";
+                reg = <0x0 0xf8000000 0x0 0x1000>;
+                #interrupt-cells = <2>;
+                interrupt-controller;
+                pmu_irq_gpio = <&gpio_pmu_irq_n>;
+                status = "ok";
+	};
 };
-- 
1.7.9.5
