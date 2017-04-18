From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 18 Apr 2017 18:57:58 +0100
Subject: [PATCH 1/2] arm64: dts: juno: fix few unit address format warnings
Message-ID: <1492538279-16405-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following set of warnings on juno.

 smb at 08000000 unit name should not have leading 0s
 sysctl at 020000 simple-bus unit address format error, expected "20000"
 apbregs at 010000 simple-bus unit address format error, expected "10000"
 mmci at 050000 simple-bus unit address format error, expected "50000"
 kmi at 060000 simple-bus unit address format error, expected "60000"
 kmi at 070000 simple-bus unit address format error, expected "70000"
 wdt at 0f0000 simple-bus unit address format error, expected "f0000"

Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi        |  2 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 8ffaff2043d0..bfe7d683a42e 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -699,7 +699,7 @@
 		      <0x00000008 0x80000000 0x1 0x80000000>;
 	};

-	smb at 08000000 {
+	smb at 8000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 098601657f82..2ac43221ddb6 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -137,7 +137,7 @@
 				#size-cells = <1>;
 				ranges = <0 3 0 0x200000>;

-				v2m_sysctl: sysctl at 020000 {
+				v2m_sysctl: sysctl at 20000 {
 					compatible = "arm,sp810", "arm,primecell";
 					reg = <0x020000 0x1000>;
 					clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&mb_clk24mhz>;
@@ -148,7 +148,7 @@
 					assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
 				};

-				apbregs at 010000 {
+				apbregs at 10000 {
 					compatible = "syscon", "simple-mfd";
 					reg = <0x010000 0x1000>;

@@ -216,7 +216,7 @@
 					};
 				};

-				mmci at 050000 {
+				mmci at 50000 {
 					compatible = "arm,pl180", "arm,primecell";
 					reg = <0x050000 0x1000>;
 					interrupts = <5>;
@@ -228,7 +228,7 @@
 					clock-names = "mclk", "apb_pclk";
 				};

-				kmi at 060000 {
+				kmi at 60000 {
 					compatible = "arm,pl050", "arm,primecell";
 					reg = <0x060000 0x1000>;
 					interrupts = <8>;
@@ -236,7 +236,7 @@
 					clock-names = "KMIREFCLK", "apb_pclk";
 				};

-				kmi at 070000 {
+				kmi at 70000 {
 					compatible = "arm,pl050", "arm,primecell";
 					reg = <0x070000 0x1000>;
 					interrupts = <8>;
@@ -244,7 +244,7 @@
 					clock-names = "KMIREFCLK", "apb_pclk";
 				};

-				wdt at 0f0000 {
+				wdt at f0000 {
 					compatible = "arm,sp805", "arm,primecell";
 					reg = <0x0f0000 0x10000>;
 					interrupts = <7>;
--
2.7.4
