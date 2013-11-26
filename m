From: lho@apm.com (Loc Ho)
Date: Mon, 25 Nov 2013 22:46:58 -0700
Subject: [PATCH v3 4/4] arm64: Add APM X-Gene SoC 15Gbps Multi-purpose PHY DTS
 entries
In-Reply-To: <1385444818-29682-4-git-send-email-lho@apm.com>
References: <1385444818-29682-1-git-send-email-lho@apm.com>
 <1385444818-29682-2-git-send-email-lho@apm.com>
 <1385444818-29682-3-git-send-email-lho@apm.com>
 <1385444818-29682-4-git-send-email-lho@apm.com>
Message-ID: <1385444818-29682-5-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: Add APM X-Gene SoC 15Gbps Multi-purpose PHY DTS entries

This patch adds the DTS entries for the APM X-Gene SoC 15Gbps Multi-purpose
PHY driver. The PHY for SATA controller 0 and 1 are enabled by default.

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 359d7b6..f74c26a 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -193,5 +193,36 @@
 			reg = <0x0 0x17000014 0x0 0x100>;
 			mask = <0x1>;
 		};
+
+		phy1: phy at 1f210000 {
+			compatible = "apm,xgene-phy";
+			reg = <0x0 0x1f21a000 0x0 0x100>,
+			      <0x0 0x1f21c000 0x0 0x100>;
+			#phy-cells = <1>;
+			status = "disabled";
+			apm-tx-boost-gain = <0x2 0x2 0x2 0x2 0x2 0x2>;
+			apm-tx-eye-tuning = <0xa 0xa 0xa 0xa 0xa 0xa>;
+		};
+
+		phy2: phy at 1f220000 {
+			compatible = "apm,xgene-phy";
+			reg = <0x0 0x1f22a000 0x0 0x100>,
+			      <0x0 0x1f22c000 0x0 0x100>;
+			#phy-cells = <1>;
+			status = "ok";
+			apm-tx-boost-gain = <0x2 0x2 0x2 0x2 0x2 0x2>;
+			apm-tx-eye-tuning = <0xa 0xa 0xa 0x5 0x5 0x5>;
+		};
+
+		phy3: phy at 1f230000 {
+			compatible = "apm,xgene-phy-ext";
+			reg = <0x0 0x1f23a000 0x0 0x100>,
+			      <0x0 0x1f23c000 0x0 0x100>,
+			      <0x0 0x1f2d0000 0x0 0x100>;
+			#phy-cells = <1>;
+			status = "ok";
+			apm-tx-boost-gain = <0x3 0x3 0x3 0x3 0x3 0x3>;
+			apm-tx-eye-tuning = <0xa 0xa 0xa 0xc 0xc 0xc>;
+		};
 	};
 };
-- 
1.5.5
