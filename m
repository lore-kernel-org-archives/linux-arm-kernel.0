From: lho@apm.com (Loc Ho)
Date: Fri, 29 May 2015 16:04:35 -0600
Subject: [PATCH 3/3] arm64: Add L3/SoC DT subnodes to the APM X-Gene SoC EDAC
 node
In-Reply-To: <1432937075-16558-3-git-send-email-lho@apm.com>
References: <1432937075-16558-1-git-send-email-lho@apm.com>
 <1432937075-16558-2-git-send-email-lho@apm.com>
 <1432937075-16558-3-git-send-email-lho@apm.com>
Message-ID: <1432937075-16558-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds L3/SoC DT subnodes to the APM X-Gene SoC EDAC node.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 577799f..9ebc0d4 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -455,6 +455,16 @@
 				reg = <0x0 0x7c600000 0x0 0x200000>;
 				pmd-controller = <3>;
 			};
+
+			edacl3 at 7e600000 {
+				compatible = "apm,xgene-edac-l3";
+				reg = <0x0 0x7e600000 0x0 0x1000>;
+			};
+
+			edacsoc at 7e930000 {
+				compatible = "apm,xgene-edac-soc";
+				reg = <0x0 0x7e930000 0x0 0x1000>;
+			};
 		};
 
 		pcie0: pcie at 1f2b0000 {
-- 
1.7.1
