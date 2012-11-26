From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 Nov 2012 16:55:08 +0530
Subject: [PATCH 08/14] ARM: SPEAr: DT: Update device nodes
In-Reply-To: <b3925b105ee2c6fe828ef3b54928aeee02a801ae.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <b3925b105ee2c6fe828ef3b54928aeee02a801ae.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <CAKohpomH84SfHjZ78Rp9UoXgUZkTjFVoWPK_8N3dL5pxYhOWfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 November 2012 10:09, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> From: Shiraz Hashim <shiraz.hashim@st.com>
>
> This patch adds multiple device nodes for SPEAr machines and boards.
>
> Signed-off-by: Bhavna Yadav <bhavna.yadav@st.com>
> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Vijay Kumar Mishra <vijay.kumar@st.com>
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Arnd/Olof,

As discussed (With Arnd) over IRC, i would be sending a PULL request for
this patchset.

There are few updates/fixes in the bindings for few nodes (as the
drivers for them
just got pushed by their maintainers after some updates) and here is a diff
for that. I will merge this diff with current patch in my PULL request.

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 26 Nov 2012 16:44:53 +0530
Subject: [PATCH] fixup! ARM: SPEAr: DT: Update device nodes

---
 arch/arm/boot/dts/spear1310-evb.dts | 14 ++++----------
 arch/arm/boot/dts/spear1340-evb.dts | 25 ++++++++-----------------
 arch/arm/boot/dts/spear13xx.dtsi    | 14 +++++++-------
 3 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts
b/arch/arm/boot/dts/spear1310-evb.dts
index cd4e2f8..b56a801 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -348,7 +348,6 @@
 				cs-gpios = <&gpio1 7 0>, <&spics 0>, <&spics 1>;

 				stmpe610 at 0 {
-					status = "okay";
 					compatible = "st,stmpe610";
 					reg = <0>;
 					#address-cells = <1>;
@@ -364,15 +363,12 @@
 					pl022,ctrl-len = <0x7>;
 					pl022,wait-state = <0>;
 					pl022,duplex = <0>;
-					id = <0>;
-					blocks = <4>;
-					irq_over_gpio;
-					irq-gpios = <&gpio1 6 0x4>;
+					interrupts = <6 0x4>;
+					interrupt-parent = <&gpio1>;
 					irq-trigger = <0x2>;

-					stmpe610-ts {
-						compatible = "stmpe,ts";
-						reg = <0>;
+					stmpe_touchscreen {
+						compatible = "st,stmpe-ts";
 						ts,sample-time = <4>;
 						ts,mod-12b = <1>;
 						ts,ref-sel = <0>;
@@ -386,7 +382,6 @@
 				};

 				m25p80 at 1 {
-					status = "okay";
 					compatible = "st,m25p80";
 					reg = <1>;
 					spi-max-frequency = <12000000>;
@@ -404,7 +399,6 @@
 				};

 				spidev at 2 {
-					status = "okay";
 					compatible = "spidev";
 					reg = <2>;
 					spi-max-frequency = <25000000>;
diff --git a/arch/arm/boot/dts/spear1340-evb.dts
b/arch/arm/boot/dts/spear1340-evb.dts
index c519fa1..d6c30ae 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -319,15 +319,12 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0x41>;
-					irq-over-gpio;
-					irq-gpios = <&gpio0 4 0x4>;
-					id = <0>;
-					blocks = <1>;
+					interrupts = <4 0x4>;
+					interrupt-parent = <&gpio0>;
 					irq-trigger = <0x2>;

-					stmpegpio: stmpe-gpio {
-						compatible = "stmpe,gpio";
-						reg = <0>;
+					stmpegpio: stmpe_gpio {
+						compatible = "st,stmpe-gpio";
 						gpio-controller;
 						#gpio-cells = <2>;
 					};
@@ -445,7 +442,6 @@
 					   <&gpiopinctrl 85 0>;

 				m25p80 at 0 {
-					status = "okay";
 					compatible = "m25p80";
 					reg = <0>;
 					spi-max-frequency = <12000000>;
@@ -463,7 +459,6 @@
 				};

 				stmpe610 at 1 {
-					status = "okay";
 					compatible = "st,stmpe610";
 					spi-max-frequency = <1000000>;
 					spi-cpha;
@@ -477,17 +472,14 @@
 					pl022,ctrl-len = <0x7>;
 					pl022,wait-state = <0>;
 					pl022,duplex = <0>;
-					irq-over-gpio;
-					irq-gpios = <&gpiopinctrl 100 0>;
-					id = <0>;
-					blocks = <4>;
+					interrupts = <100 0>;
+					interrupt-parent = <&gpiopinctrl>;
 					irq-trigger = <0x2>;
 					#address-cells = <1>;
 					#size-cells = <0>;

-					stmpe610-ts {
-						compatible = "stmpe,ts";
-						reg = <0>;
+					stmpe_touchscreen {
+						compatible = "st,stmpe-ts";
 						ts,sample-time = <4>;
 						ts,mod-12b = <1>;
 						ts,ref-sel = <0>;
@@ -501,7 +493,6 @@
 				};

 				spidev at 2 {
-					status = "okay";
 					compatible = "spidev";
 					reg = <2>;
 					spi-max-frequency = <25000000>;
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 2e650f9..009096d 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -65,14 +65,14 @@
 	};

 	cpufreq {
-		compatible = "st,cpufreq";
+		compatible = "st,cpufreq-spear";
 		cpufreq_tbl = < 166000
-			200000
-			250000
-			300000
-			400000
-			500000
-			600000 >;
+				200000
+				250000
+				300000
+				400000
+				500000
+				600000 >;
 		status = "disable";
 	};

--
viresh
