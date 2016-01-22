From: lho@apm.com (Loc Ho)
Date: Fri, 22 Jan 2016 13:47:05 -0700
Subject: [PATCH v3 3/3] arm64: Update the APM X-Gene EDAC node with the RB
 register resource
In-Reply-To: <1453495625-28006-1-git-send-email-lho@apm.com>
References: <1453495625-28006-1-git-send-email-lho@apm.com>
Message-ID: <1453495625-28006-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the RB register resource as requires with the updated driver.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index fe30f76..3e40bd4 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -493,6 +493,11 @@
 			reg = <0x0 0x1054a000 0x0 0x20>;
 		};
 
+		rb: rb at 7e000000 {
+			compatible = "apm,xgene-rb", "syscon";
+			reg = <0x0 0x7e000000 0x0 0x10>;
+		};
+
 		edac at 78800000 {
 			compatible = "apm,xgene-edac";
 			#address-cells = <2>;
@@ -502,6 +507,7 @@
 			regmap-mcba = <&mcba>;
 			regmap-mcbb = <&mcbb>;
 			regmap-efuse = <&efuse>;
+			regmap-rb = <&rb>;
 			reg = <0x0 0x78800000 0x0 0x100>;
 			interrupts = <0x0 0x20 0x4>,
 				     <0x0 0x21 0x4>,
-- 
1.7.1
