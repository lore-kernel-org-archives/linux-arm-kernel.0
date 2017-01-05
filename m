From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  4 Jan 2017 18:21:34 -0600
Subject: [PATCH 12/12] ARM: dts: socfpga: add missing compatible string for
 SDRAM controller
In-Reply-To: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
References: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1483575694-29599-13-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "altr,sdr-ctl" to the SDRAM controller node.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index dccc281..bced4ca 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -782,7 +782,7 @@
 		};
 
 		sdr: sdr at ffc25000 {
-			compatible = "syscon";
+			compatible = "altr,sdr-ctl", "syscon";
 			reg = <0xffc25000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index ee53951..074bf62 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -595,7 +595,7 @@
 		};
 
 		sdr: sdr at ffc25000 {
-			compatible = "syscon";
+			compatible = "altr,sdr-ctl", "syscon";
 			reg = <0xffcfb100 0x80>;
 		};
 
-- 
2.7.4
