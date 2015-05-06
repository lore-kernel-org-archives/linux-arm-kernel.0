From: lho@apm.com (Loc Ho)
Date: Tue,  5 May 2015 22:02:27 -0600
Subject: [PATCH v8 5/5] arm64: Add APM X-Gene SoC memory controller EDAC DTS
 entries
In-Reply-To: <1430884947-16787-5-git-send-email-lho@apm.com>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
 <1430884947-16787-2-git-send-email-lho@apm.com>
 <1430884947-16787-3-git-send-email-lho@apm.com>
 <1430884947-16787-4-git-send-email-lho@apm.com>
 <1430884947-16787-5-git-send-email-lho@apm.com>
Message-ID: <1430884947-16787-6-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds APM X-Gene SoC memory controller EDAC DTS entries.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi |   64 ++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index c8d3e0e..e0270a6 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -374,6 +374,70 @@
 			};
 		};

+		pcp: pcp at 78800000 {
+			compatible = "syscon";
+			reg = <0x0 0x78800000 0x0 0x100>;
+		};
+
+		csw: csw at 7e200000 {
+			compatible = "syscon";
+			reg = <0x0 0x7e200000 0x0 0x1000>;
+		};
+
+		mcba: mcba at 7e700000 {
+			compatible = "syscon";
+			reg = <0x0 0x7e700000 0x0 0x1000>;
+		};
+
+		mcbb: mcbb at 7e720000 {
+			compatible = "syscon";
+			reg = <0x0 0x7e720000 0x0 0x1000>;
+		};
+
+		edacmc0: edacmc0 at 7e800000 {
+			compatible = "apm,xgene-edac-mc";
+			regmap-pcp = <&pcp>;
+			regmap-csw = <&csw>;
+			regmap-mcba = <&mcba>;
+			regmap-mcbb = <&mcbb>;
+			reg = <0x0 0x7e800000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>;
+		};
+
+		edacmc1: edacmc1 at 7e840000 {
+			compatible = "apm,xgene-edac-mc";
+			regmap-pcp = <&pcp>;
+			regmap-csw = <&csw>;
+			regmap-mcba = <&mcba>;
+			regmap-mcbb = <&mcbb>;
+			reg = <0x0 0x7e840000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>;
+		};
+
+		edacmc2: edacmc2 at 7e880000 {
+			compatible = "apm,xgene-edac-mc";
+			regmap-pcp = <&pcp>;
+			regmap-csw = <&csw>;
+			regmap-mcba = <&mcba>;
+			regmap-mcbb = <&mcbb>;
+			reg = <0x0 0x7e880000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>;
+		};
+
+		edacmc3: edacmc3 at 7e8c0000 {
+			compatible = "apm,xgene-edac-mc";
+			regmap-pcp = <&pcp>;
+			regmap-csw = <&csw>;
+			regmap-mcba = <&mcba>;
+			regmap-mcbb = <&mcbb>;
+			reg = <0x0 0x7e8c0000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>;
+		};
+
 		pcie0: pcie at 1f2b0000 {
 			status = "disabled";
 			device_type = "pci";
--
1.7.1
