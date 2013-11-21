From: lho@apm.com (Loc Ho)
Date: Wed, 20 Nov 2013 23:11:38 -0700
Subject: [PATCH] arm64: Add APM X-Gene SoC SATA host controller DTS entries
In-Reply-To: <1385014298-15700-4-git-send-email-lho@apm.com>
References: <1385014298-15700-1-git-send-email-lho@apm.com>
 <1385014298-15700-2-git-send-email-lho@apm.com>
 <1385014298-15700-3-git-send-email-lho@apm.com>
 <1385014298-15700-4-git-send-email-lho@apm.com>
Message-ID: <1385014298-15700-5-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: Add APM X-Gene SoC SATA host controller DTS entries

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 359d7b6..592485c 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -193,5 +193,38 @@
 			reg = <0x0 0x17000014 0x0 0x100>;
 			mask = <0x1>;
 		};
+
+		sata0: sata at 1a000000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a000000 0x0 0x100000>,
+			      <0x0 0x1f210000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x86 0x4>;
+			status = "disabled";
+			phys = <&sataphy0>;
+			phy-names = "sataphy1f210000";
+		};
+
+		sata1: sata at 1a400000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a400000 0x0 0x100000>,
+			      <0x0 0x1f220000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x87 0x4>;
+			status = "ok";
+			phys = <&sataphy1>;
+			phy-names = "sataphy1f220000";
+		};
+
+		sata2: sata at 1a800000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a800000 0x0 0x100000>,
+			      <0x0 0x1f230000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x88 0x4>;
+			status = "ok";
+			phys = <&sataphy2>;
+			phy-names = "sataphy1f230000";
+		};
 	};
 };
-- 
1.5.5
