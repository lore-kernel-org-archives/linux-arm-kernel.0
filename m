From: lho@apm.com (Loc Ho)
Date: Mon, 18 May 2015 17:24:41 -0600
Subject: [PATCH v10 5/5] arm64: Add APM X-Gene SoC EDAC DTS entries
In-Reply-To: <1431991481-25684-5-git-send-email-lho@apm.com>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-2-git-send-email-lho@apm.com>
 <1431991481-25684-3-git-send-email-lho@apm.com>
 <1431991481-25684-4-git-send-email-lho@apm.com>
 <1431991481-25684-5-git-send-email-lho@apm.com>
Message-ID: <1431991481-25684-6-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds APM X-Gene SoC EDAC DTS entries.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi |   75 ++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index c8d3e0e..51aa174 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -374,6 +374,81 @@
 			};
 		};
 
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
+		efuse: efuse at 1054a000 {
+			compatible = "syscon";
+			reg = <0x0 0x1054a000 0x0 0x20>;
+		};
+
+		edac at 78800000 {
+			compatible = "apm,xgene-edac";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			regmap-csw = <&csw>;
+			regmap-mcba = <&mcba>;
+			regmap-mcbb = <&mcbb>;
+			regmap-efuse = <&efuse>;
+			reg = <0x0 0x78800000 0x0 0x100>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>,
+				     <0x0 0x27 0x4>;
+
+			edacmc at 7e800000 {
+				compatible = "apm,xgene-edac-mc";
+				reg = <0x0 0x7e800000 0x0 0x1000>;
+			};
+
+			edacmc at 7e840000 {
+				compatible = "apm,xgene-edac-mc";
+				reg = <0x0 0x7e840000 0x0 0x1000>;
+			};
+
+			edacmc at 7e880000 {
+				compatible = "apm,xgene-edac-mc";
+				reg = <0x0 0x7e880000 0x0 0x1000>;
+			};
+
+			edacmc at 7e8c0000 {
+				compatible = "apm,xgene-edac-mc";
+				reg = <0x0 0x7e8c0000 0x0 0x1000>;
+			};
+
+			edacpmd at 7c000000 {
+				compatible = "apm,xgene-edac-pmd";
+				reg = <0x0 0x7c000000 0x0 0x200000>;
+			};
+
+			edacpmd at 7c200000 {
+				compatible = "apm,xgene-edac-pmd";
+				reg = <0x0 0x7c200000 0x0 0x200000>;
+			};
+
+			edacpmd at 7c400000 {
+				compatible = "apm,xgene-edac-pmd";
+				reg = <0x0 0x7c400000 0x0 0x200000>;
+			};
+
+			edacpmd at 7c600000 {
+				compatible = "apm,xgene-edac-pmd";
+				reg = <0x0 0x7c600000 0x0 0x200000>;
+			};
+		};
+
 		pcie0: pcie at 1f2b0000 {
 			status = "disabled";
 			device_type = "pci";
-- 
1.7.1
