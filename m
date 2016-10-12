From: jun.nie@linaro.org (Jun Nie)
Date: Wed, 12 Oct 2016 10:14:16 +0800
Subject: [PATCH 2/2] arm64: dts: zx: Add clock controller nodes
In-Reply-To: <1476238456-20420-1-git-send-email-jun.nie@linaro.org>
References: <1476238456-20420-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1476238456-20420-2-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock controller nodes, including one top controller
two low speed controllers and one audio controller.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 6b239a3..33e42d5 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -279,9 +279,33 @@
 			dma-requests = <32>;
 		};
 
+		lsp0crm: clock-controller at 01420000 {
+			compatible = "zte,zx296718-lsp0crm";
+			reg = <0x01420000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		lsp1crm: clock-controller at 01430000 {
+			compatible = "zte,zx296718-lsp1crm";
+			reg = <0x01430000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		topcrm: clock-controller at 01461000 {
+			compatible = "zte,zx296718-topcrm";
+			reg = <0x01461000 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		sysctrl: sysctrl at 1463000 {
 			compatible = "zte,zx296718-sysctrl", "syscon";
 			reg = <0x1463000 0x1000>;
 		};
+
+		audiocrm: clock-controller at 01480000 {
+			compatible = "zte,zx296718-audiocrm";
+			reg = <0x01480000 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 };
-- 
1.9.1
