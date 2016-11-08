From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue,  8 Nov 2016 15:50:12 -0600
Subject: [PATCHv3] ARM: dts: socfpga: add specific compatible strings for
 boards
Message-ID: <20161108215012.23647-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a more specific board compatible entry for all of the SOCFPGA
Cyclone 5 based boards.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v3: Be a bit more specific with the c5 dk and sockit, use
    "altr,socfpga-cyclone5-socdk" and "terasic,socfpga-cyclone5-sockit"
v2: remove extra space and add a comma between compatible entries
---
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
index afea364..5ecd2ef 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
@@ -18,7 +18,7 @@
 
 / {
 	model = "Terasic DE-0(Atlas)";
-	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+	compatible = "terasic,de0-atlas", "altr,socfpga-cyclone5", "altr,socfpga";
 
 	chosen {
 		bootargs = "earlyprintk";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
index 424523b..e5a98e5 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
@@ -19,7 +19,7 @@
 
 / {
 	model = "Aries/DENX MCV EVK";
-	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+	compatible = "denx,mcvevk", "altr,socfpga-cyclone5", "altr,socfpga";
 
 	aliases {
 		ethernet0 = &gmac0;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 15e43f4..7a5f42d 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -19,7 +19,7 @@
 
 / {
 	model = "Altera SOCFPGA Cyclone V SoC Development Kit";
-	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+	compatible = "altr,socfpga-cyclone5-socdk", "altr,socfpga-cyclone5", "altr,socfpga";
 
 	chosen {
 		bootargs = "earlyprintk";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index 02e22f5..fcacaf7b 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -19,7 +19,7 @@
 
 / {
 	model = "Terasic SoCkit";
-	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+	compatible = "terasic,socfpga-cyclone5-sockit", "altr,socfpga-cyclone5", "altr,socfpga";
 
 	chosen {
 		bootargs = "earlyprintk";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
index 9aaf413..5b7e3c2 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
@@ -21,7 +21,7 @@
 
 / {
 	model = "Altera SOCFPGA Cyclone V SoC Macnica Sodia board";
-	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+	compatible = "macnica,sodia", "altr,socfpga-cyclone5", "altr,socfpga";
 
 	chosen {
 		bootargs = "earlyprintk";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index b844473..363ee62 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -51,7 +51,7 @@
 
 / {
 	model = "samtec VIN|ING FPGA";
-	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+	compatible = "samtec,vining", "altr,socfpga-cyclone5", "altr,socfpga";
 
 	chosen {
 		bootargs = "console=ttyS0,115200";
-- 
2.8.3
