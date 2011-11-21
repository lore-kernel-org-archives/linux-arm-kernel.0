From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 21 Nov 2011 14:44:10 -0700
Subject: [PATCH 4/5] arm/dt: tegra: Fix serial nodes to match board files
In-Reply-To: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
Message-ID: <1321911851-10091-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark any serial ports that aren't registered by the board files as disabled
in the device-tree files.

In practice, none of the now-disabled ports ended up succeeding device
probing because of the missing clock-frequency property. However,
explicitly marking the devices disabled has the advantage of squashing
the dev_warn() the failed probe causes, and documenting that we intend
the port not to be used, rather than accidentally left out the property.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-harmony.dts   |   16 ++++++++++++++++
 arch/arm/boot/dts/tegra-seaboard.dts  |   16 ++++++++++++++++
 arch/arm/boot/dts/tegra-trimslice.dts |   16 ++++++++++++++++
 arch/arm/boot/dts/tegra-ventana.dts   |   16 ++++++++++++++++
 4 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index ca6fa10..ac179a0 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -47,10 +47,26 @@
 		ext-mic-en-gpios = <&gpio 185 0>;
 	};
 
+	serial at 70006000 {
+		status = "disable";
+	};
+
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		status = "disable";
+	};
+
 	serial at 70006300 {
 		clock-frequency = < 216000000 >;
 	};
 
+	serial at 70006400 {
+		status = "disable";
+	};
+
 	sdhci at c8000200 {
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index 92da1f1..cbb2f08 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -27,10 +27,26 @@
 		clock-frequency = <400000>;
 	};
 
+	serial at 70006000 {
+		status = "disable";
+	};
+
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		status = "disable";
+	};
+
 	serial at 70006300 {
 		clock-frequency = < 216000000 >;
 	};
 
+	serial at 70006400 {
+		status = "disable";
+	};
+
 	sdhci at c8000400 {
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index b1aaa45..6060ce0 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -30,6 +30,22 @@
 		clock-frequency = < 216000000 >;
 	};
 
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		status = "disable";
+	};
+
+	serial at 70006300 {
+		status = "disable";
+	};
+
+	serial at 70006400 {
+		status = "disable";
+	};
+
 	sdhci at c8000600 {
 		cd-gpios = <&gpio 121 0>;
 		wp-gpios = <&gpio 122 0>;
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 0f14ee3..5ac0aa3 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -26,10 +26,26 @@
 		clock-frequency = <400000>;
 	};
 
+	serial at 70006000 {
+		status = "disable";
+	};
+
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		status = "disable";
+	};
+
 	serial at 70006300 {
 		clock-frequency = < 216000000 >;
 	};
 
+	serial at 70006400 {
+		status = "disable";
+	};
+
 	sdhci at c8000400 {
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
-- 
1.7.0.4
