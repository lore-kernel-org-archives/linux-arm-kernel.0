From: lho@apm.com (Loc Ho)
Date: Thu, 14 Nov 2013 12:31:59 -0700
Subject: [PATCH 3/3] arm64: Add APM X-Gene SoC 6.0Gbps SATA PHY DTS entries
In-Reply-To: <1384457519-21335-3-git-send-email-lho@apm.com>
References: <1384457519-21335-1-git-send-email-lho@apm.com>
 <1384457519-21335-2-git-send-email-lho@apm.com>
 <1384457519-21335-3-git-send-email-lho@apm.com>
Message-ID: <1384457519-21335-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: Add APM X-Gene SoC 6.0Gbps SATA PHY DTS entries.

This patch adds the DTS entries for the APM X-Gene SoC 6.0Gbps SATA PHY 
driver. The PHY for controller 0 and 1 are enabled by default.
---
 arch/arm64/boot/dts/apm-storm.dtsi |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 359d7b6..b29b465 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -193,5 +193,30 @@
 			reg = <0x0 0x17000014 0x0 0x100>;
 			mask = <0x1>;
 		};
+
+		sataphy0: sataphy at 1f210000 {
+			compatible = "apm,xgene-ahci-phy";
+			id = <0>;
+			reg = <0x0 0x1f210000 0x0 0x10000>;
+			#phy-cells = <0>;
+			status = "na";
+		};
+
+		sataphy1: sataphy at 1f220000 {
+			compatible = "apm,xgene-ahci-phy";
+			id = <1>;
+			reg = <0x0 0x1f220000 0x0 0x10000>;
+			#phy-cells = <0>;
+			status = "ok";
+		};
+
+		sataphy2: sataphy at 1f230000 {
+			compatible = "apm,xgene-ahci-phy";
+			id = <2>;
+			reg = <0x0 0x1f230000 0x0 0x10000
+			       0x0 0x1f2d0000 0x0 0x10000 >;
+			#phy-cells = <0>;
+			status = "ok";
+		};
 	};
 };
-- 
1.5.5
