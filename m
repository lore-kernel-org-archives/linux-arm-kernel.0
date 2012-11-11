From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:29 +0530
Subject: [PATCH 07/14] ARM: SPEAr: DT: add uart state to fix warning
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <4c8084c7c40a050f858555bd6325e22e45bb0ecf.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

amba-pl011 driver supports two pin state "default" and "sleep" and it
expect from dt to provide this pinctrl states and phandler otherwise it
gives a warning message.

To remove this warning message pass default state with null phandler to uart
pins in device node (In our case all the pins are configured in default states
so we pass null phandler to pins).

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear1310-evb.dts |  2 ++
 arch/arm/boot/dts/spear1340-evb.dts |  4 ++++
 arch/arm/boot/dts/spear300-evb.dts  |  2 ++
 arch/arm/boot/dts/spear310-evb.dts  | 12 ++++++++++++
 arch/arm/boot/dts/spear320-evb.dts  |  6 ++++++
 arch/arm/boot/dts/spear600-evb.dts  |  4 ++++
 6 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index a4ff5cb..c60c3f8 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -320,6 +320,8 @@
 
 			serial at e0000000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			spi0: spi at e0100000 {
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index 63c352f..c6051dd 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -332,10 +332,14 @@
 
 			serial at e0000000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			serial at b4100000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			spi0: spi at e0100000 {
diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts
index b3265f6..5de1431 100644
--- a/arch/arm/boot/dts/spear300-evb.dts
+++ b/arch/arm/boot/dts/spear300-evb.dts
@@ -243,6 +243,8 @@
 
 			serial at d0000000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			wdt at fc880000 {
diff --git a/arch/arm/boot/dts/spear310-evb.dts b/arch/arm/boot/dts/spear310-evb.dts
index b30fa0e..b096329 100644
--- a/arch/arm/boot/dts/spear310-evb.dts
+++ b/arch/arm/boot/dts/spear310-evb.dts
@@ -166,26 +166,38 @@
 
 			serial at d0000000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			serial at b2000000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			serial at b2080000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			serial at b2100000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			serial at b2180000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			serial at b2200000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			wdt at fc880000 {
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index d62ee20..02f06c5 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -179,14 +179,20 @@
 
 			serial at d0000000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			serial at a3000000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			serial at a4000000 {
 			       status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			wdt at fc880000 {
diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
index 16e4de4..5e6ef03 100644
--- a/arch/arm/boot/dts/spear600-evb.dts
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -73,10 +73,14 @@
 		apb {
 			serial at d0000000 {
 				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			serial at d0080000 {
 				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <>;
 			};
 
 			i2c at d0200000 {
-- 
1.7.12.rc2.18.g61b472e
