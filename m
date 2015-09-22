From: nm@ti.com (Nishanth Menon)
Date: Tue, 22 Sep 2015 11:08:38 -0500
Subject: [PATCH 3/3] ARM: dts: keystone: Update SoC specific compatible flags
In-Reply-To: <1442938118-4718-1-git-send-email-nm@ti.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
Message-ID: <1442938118-4718-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the compatible flags to allow specific SoC identification.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/k2e-evm.dts   | 2 +-
 arch/arm/boot/dts/k2e.dtsi      | 3 +++
 arch/arm/boot/dts/k2hk-evm.dts  | 2 +-
 arch/arm/boot/dts/k2hk.dtsi     | 3 +++
 arch/arm/boot/dts/k2l-evm.dts   | 2 +-
 arch/arm/boot/dts/k2l.dtsi      | 3 +++
 arch/arm/boot/dts/keystone.dtsi | 1 +
 7 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/k2e-evm.dts b/arch/arm/boot/dts/k2e-evm.dts
index 50c83c21d911..b7e99807f5c2 100644
--- a/arch/arm/boot/dts/k2e-evm.dts
+++ b/arch/arm/boot/dts/k2e-evm.dts
@@ -13,7 +13,7 @@
 #include "k2e.dtsi"
 
 / {
-	compatible =  "ti,k2e-evm","ti,keystone";
+	compatible = "ti,k2e-evm", "ti,k2e", "ti,keystone";
 	model = "Texas Instruments Keystone 2 Edison EVM";
 
 	soc {
diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index 675fb8e492c6..1097dada56d2 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -9,6 +9,9 @@
  */
 
 / {
+	compatible = "ti,k2e", "ti,keystone";
+	model = "Texas Instruments Keystone 2 Edison SoC";
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 660ebf58d547..8161bf53271b 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -13,7 +13,7 @@
 #include "k2hk.dtsi"
 
 / {
-	compatible =  "ti,k2hk-evm","ti,keystone";
+	compatible =  "ti,k2hk-evm", "ti,k2hk", "ti,keystone";
 	model = "Texas Instruments Keystone 2 Kepler/Hawking EVM";
 
 	soc {
diff --git a/arch/arm/boot/dts/k2hk.dtsi b/arch/arm/boot/dts/k2hk.dtsi
index d0810a5f2968..ada4c7ac96e7 100644
--- a/arch/arm/boot/dts/k2hk.dtsi
+++ b/arch/arm/boot/dts/k2hk.dtsi
@@ -9,6 +9,9 @@
  */
 
 / {
+	compatible = "ti,k2hk", "ti,keystone";
+	model = "Texas Instruments Keystone 2 Kepler/Hawking SoC";
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/k2l-evm.dts b/arch/arm/boot/dts/k2l-evm.dts
index 9a69a6b55374..00861244d788 100644
--- a/arch/arm/boot/dts/k2l-evm.dts
+++ b/arch/arm/boot/dts/k2l-evm.dts
@@ -13,7 +13,7 @@
 #include "k2l.dtsi"
 
 / {
-	compatible =  "ti,k2l-evm","ti,keystone";
+	compatible = "ti,k2l-evm", "ti,k2l", "ti,keystone";
 	model = "Texas Instruments Keystone 2 Lamarr EVM";
 
 	soc {
diff --git a/arch/arm/boot/dts/k2l.dtsi b/arch/arm/boot/dts/k2l.dtsi
index 49fd414f680c..4446da72b0ae 100644
--- a/arch/arm/boot/dts/k2l.dtsi
+++ b/arch/arm/boot/dts/k2l.dtsi
@@ -9,6 +9,9 @@
  */
 
 / {
+	compatible = "ti,k2l", "ti,keystone";
+	model = "Texas Instruments Keystone 2 Lamarr SoC";
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 72816d65f7ec..ff91f703d371 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -12,6 +12,7 @@
 #include "skeleton.dtsi"
 
 / {
+	compatible = "ti,keystone";
 	model = "Texas Instruments Keystone 2 SoC";
 	#address-cells = <2>;
 	#size-cells = <2>;
-- 
2.1.4
