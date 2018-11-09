From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:14:02 +0530
Subject: [PATCH v5 03/18] arm64: dts: qcom: qcs404: Add reserved-memory regions
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Message-ID: <20181109094417.12109-4-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the reserved memory regions in QCS404

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 91abcdc78505..d40f3923ed69 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -73,6 +73,47 @@
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		memory at 85600000 {
+			reg = <0 0x85600000 0 0x90000>;
+			no-map;
+		};
+
+		smem_region: memory at 85f00000 {
+			reg = <0 0x85f00000 0 0x200000>;
+			no-map;
+		};
+
+		memory at 86100000 {
+			reg = <0 0x86100000 0 0x300000>;
+			no-map;
+		};
+
+		wlan_fw_mem: memory at 86400000 {
+			reg = <0 0x86400000 0 0x1c00000>;
+			no-map;
+		};
+
+		adsp_fw_mem: memory at 88000000 {
+			reg = <0 0x88000000 0 0x1a00000>;
+			no-map;
+		};
+
+		cdsp_fw_mem: memory at 89a00000 {
+			reg = <0 0x89a00000 0 0x600000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory at 8a000000 {
+			reg = <0 0x8a000000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	soc: soc at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.14.4
