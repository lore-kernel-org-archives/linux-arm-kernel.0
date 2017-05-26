From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 26 May 2017 14:35:13 +0800
Subject: [PATCH 1/6] dt-bindings: mfd: Add hi6421v530 bindings
In-Reply-To: <20170526063518.21246-1-guodong.xu@linaro.org>
References: <20170526063518.21246-1-guodong.xu@linaro.org>
Message-ID: <20170526063518.21246-2-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT bindings for hisilicon HI655x PMIC chip.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 .../bindings/mfd/hisilicon,hi6421v530.txt          | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421v530.txt

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421v530.txt b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421v530.txt
new file mode 100644
index 0000000..6ffe6f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421v530.txt
@@ -0,0 +1,25 @@
+Hisilicon Hi6421v530 Power Management Integrated Circuit (PMIC)
+
+The hardware layout for access PMIC Hi6421v530 from AP SoC Hi3660.
+Between PMIC Hi6421v530 and Hi3660, the physical signal channel is SSI.
+We can use memory-mapped I/O to communicate.
+
++----------------+             +-------------+
+|                |             |             |
+|    Hi3660      |   SSI bus   |  Hi6421v530 |
+|                |-------------|             |
+|                |(REGMAP_MMIO)|             |
++----------------+             +-------------+
+
+Required properties:
+- compatible:           Should be "hisilicon,hi6421v530-pmic".
+- reg:                  Base address of PMIC on Hi3660 SoC.
+- interrupt-controller: Hi6421v530 has internal IRQs (has own IRQ domain).
+
+Example:
+	pmic: pmic at fff34000 {
+		compatible = "hisilicon,hi6421v530-pmic";
+		reg = <0x0 0xfff34000 0x0 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	}
-- 
2.10.2
