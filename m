From: lho@apm.com (Loc Ho)
Date: Tue, 19 Nov 2013 16:53:17 -0700
Subject: [PATCH v2 4/4] arm64: Add APM X-Gene SoC 6.0Gbps SATA PHY DTS entries
In-Reply-To: <1384905197-3566-4-git-send-email-lho@apm.com>
References: <1384905197-3566-1-git-send-email-lho@apm.com>
 <1384905197-3566-2-git-send-email-lho@apm.com>
 <1384905197-3566-3-git-send-email-lho@apm.com>
 <1384905197-3566-4-git-send-email-lho@apm.com>
Message-ID: <1384905197-3566-5-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: Add APM X-Gene SoC 6.0Gbps SATA PHY DTS entries

This patch adds the DTS entries for the APM X-Gene SoC 6.0Gbps SATA PHY
driver. The PHY for controller 0 and 1 are enabled by default.

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 359d7b6..1d1c8bc 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -193,5 +193,33 @@
 			reg = <0x0 0x17000014 0x0 0x100>;
 			mask = <0x1>;
 		};
+
+		sataphy0: sataphy at 1f210000 {
+			compatible = "apm,xgene-ahci-phy";
+			reg = <0x0 0x1f210000 0x0 0x10000>;
+			#phy-cells = <0>;
+			status = "na";
+			txbooster = <0x2 0x2 0x2 0x2 0x2 0x2>;
+			txskew = <0xa 0xa 0xa 0xa 0xa 0xa>;
+		};
+
+		sataphy1: sataphy at 1f220000 {
+			compatible = "apm,xgene-ahci-phy";
+			reg = <0x0 0x1f220000 0x0 0x10000>;
+			#phy-cells = <0>;
+			status = "ok";
+			txbooster = <0x2 0x2 0x2 0x2 0x2 0x2>;
+			txskew = <0xa 0xa 0xa 0x5 0x5 0x5>;
+		};
+
+		sataphy2: sataphy at 1f230000 {
+			compatible = "apm,xgene-ahci-phy2";
+			reg = <0x0 0x1f230000 0x0 0x10000
+			       0x0 0x1f2d0000 0x0 0x10000>;
+			#phy-cells = <0>;
+			status = "ok";
+			txbooster = <0x3 0x3 0x3 0x3 0x3 0x3>;
+			txskew = <0xa 0xa 0xa 0xc 0xc 0xc>;
+		};
 	};
 };
-- 
1.5.5
