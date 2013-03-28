From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Thu, 28 Mar 2013 12:12:38 +0530
Subject: [PATCH-V2 1/6] ARM: dts: AM33XX: Fix the i2c numbering to match
 hardware/TRM
In-Reply-To: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1364452963-22083-2-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT support, where naming convention is based on base-addr
and not id, so we should follow TRM/Spec numbering label.

This patch changes I2C numbering as per TRM, as I2C0, I2C1 and I2C2.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Matt Porter <mporter@ti.com>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts  |    2 +-
 arch/arm/boot/dts/am335x-evm.dts   |    4 ++--
 arch/arm/boot/dts/am335x-evmsk.dts |    2 +-
 arch/arm/boot/dts/am33xx.dtsi      |    6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 11b240c..cdc8307 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -43,7 +43,7 @@
 			status = "okay";
 		};

-		i2c1: i2c at 44e0b000 {
+		i2c0: i2c at 44e0b000 {
 			status = "okay";
 			clock-frequency = <400000>;

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d649644..a6539ad 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -51,7 +51,7 @@
 			status = "okay";
 		};

-		i2c1: i2c at 44e0b000 {
+		i2c0: i2c at 44e0b000 {
 			status = "okay";
 			clock-frequency = <400000>;

@@ -60,7 +60,7 @@
 			};
 		};

-		i2c2: i2c at 4802a000 {
+		i2c1: i2c at 4802a000 {
 			status = "okay";
 			clock-frequency = <100000>;

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index f5a6162..45cb39a 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -58,7 +58,7 @@
 			status = "okay";
 		};

-		i2c1: i2c at 44e0b000 {
+		i2c0: i2c at 44e0b000 {
 			status = "okay";
 			clock-frequency = <400000>;

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0957645..c38b2fa 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -185,7 +185,7 @@
 			status = "disabled";
 		};

-		i2c1: i2c at 44e0b000 {
+		i2c0: i2c at 44e0b000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -195,7 +195,7 @@
 			status = "disabled";
 		};

-		i2c2: i2c at 4802a000 {
+		i2c1: i2c at 4802a000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -205,7 +205,7 @@
 			status = "disabled";
 		};

-		i2c3: i2c at 4819c000 {
+		i2c2: i2c at 4819c000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
--
1.7.0.4
