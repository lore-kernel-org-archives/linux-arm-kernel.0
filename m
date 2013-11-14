From: lho@apm.com (Loc Ho)
Date: Thu, 14 Nov 2013 14:39:13 -0700
Subject: [PATCH v4 4/4] arm64: Add APM X-Gene SoC SATA DTS entries
In-Reply-To: <1384465153-29902-4-git-send-email-lho@apm.com>
References: <1384465153-29902-1-git-send-email-lho@apm.com>
 <1384465153-29902-2-git-send-email-lho@apm.com>
 <1384465153-29902-3-git-send-email-lho@apm.com>
 <1384465153-29902-4-git-send-email-lho@apm.com>
Message-ID: <1384465153-29902-5-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: Add APM X-Gene SoC SATA host controller and clock DTS entries

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   70 ++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index b29b465..14f3d5b 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -176,6 +176,36 @@
 				reg-names = "csr-reg";
 				clock-output-names = "eth8clk";
 			};
+
+			eth01clk: eth01clk at 1f21c000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "eth01clk";
+	                        reg = <0x0 0x1f21c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "eth01clk";
+			};
+
+			eth23clk: eth23clk at 1f22c000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "eth23clk";
+	                        reg = <0x0 0x1f22c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "eth23clk";
+			};
+
+			sata45clk: sata45clk at 1f23c000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "sata45clk";
+	                        reg = <0x0 0x1f23c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "sata45clk";
+			};
 		};
 
 		serial0: serial at 1c020000 {
@@ -218,5 +248,45 @@
 			#phy-cells = <0>;
 			status = "ok";
 		};
+
+		sata0: sata at 1a000000 {
+			compatible = "apm,xgene-ahci";
+			id = <0>;
+			reg =  <0x0 0x1a000000 0x0 0x100000
+				0x0 0x1f210000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x86 0x4>;
+		        clocks = <&eth01clk 0>;
+			status = "na";
+			phys = <&sataphy0>;
+			phy-names = "sataphy0";
+		};
+
+		sata1: sata at 1a400000 {
+			compatible = "apm,xgene-ahci";
+			id = <1>;
+			reg =  <0x0 0x1a400000 0x0 0x100000
+				0x0 0x1f220000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x87 0x4>;
+		        clocks = <&eth23clk 0>;
+			status = "ok";
+			phys = <&sataphy1>;
+			phy-names = "sataphy1";
+		};
+
+		sata2: sata at 1a800000 {
+			compatible = "apm,xgene-ahci";
+			id = <2>;
+			reg =  <0x0 0x1a800000 0x0 0x100000
+				0x0 0x1f230000 0x0 0x10000
+				0x0 0x1f2d0000 0x0 0x10000 >;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x88 0x4>;
+		        clocks = <&sata45clk 0>;
+			status = "ok";
+			phys = <&sataphy2>;
+			phy-names = "sataphy2";
+		};
 	};
 };
-- 
1.5.5
