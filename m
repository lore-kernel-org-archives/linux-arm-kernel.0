From: lho@apm.com (Loc Ho)
Date: Wed, 23 Sep 2015 17:41:01 -0700
Subject: [PATCH v5 4/4] arm64: Add L3/SoC DT subnodes to the APM X-Gene SoC
 EDAC node
In-Reply-To: <1443055261-8613-1-git-send-email-lho@apm.com>
References: <1443055261-8613-1-git-send-email-lho@apm.com>
Message-ID: <1443055261-8613-5-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add L3/SoC DT subnodes to the APM X-Gene SoC EDAC node.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index d831bc2..fac1720 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -477,6 +477,16 @@
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
+				compatible = "apm,xgene-edac-soc-v1";
+				reg = <0x0 0x7e930000 0x0 0x1000>;
+			};
 		};

 		pcie0: pcie at 1f2b0000 {
--
1.7.1
