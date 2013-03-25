From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 25 Mar 2013 15:02:36 +0000
Subject: [PATCH 1/3] ARM: ux500: Add device nodes for TCDM and TCPM memory
 locations
Message-ID: <1364223758-17621-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRCMU requires the Tightly Coupled Memory (TCM) locations in
order to function correctly. A recent move to send the base
addresses though the PRCMU platform device resource instead of
defines found in <mach/*>, means that dbx500 devices can no longer
boot successfully. These new nodes will allow the PRCMU to extract
the base memory locations from Device Tree instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index d3ec32f..6195ffa 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -126,6 +126,14 @@
 			 };
 		};
 
+		prcmu-tcpm-per4 at 801b0000 {
+			reg = <0x801b0000 0x1000>;
+		};
+
+		prcmu-tcdm-per4 at 801b8000 {
+			reg = <0x801b8000 0x1000>;
+		};
+
 		external-bus at 50000000 {
 			status = "okay";
 
-- 
1.7.10.4
