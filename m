From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:14:08 +0530
Subject: [PATCH v5 09/18] arm64: dts: qcom: pms405: add spmi node
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Message-ID: <20181109094417.12109-10-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pms405 DT file with spmi node.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pms405.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
new file mode 100644
index 000000000000..7b8104e21507
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pms405_0: pms405 at 0 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+	};
+};
-- 
2.14.4
