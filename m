From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 21 Nov 2011 14:44:09 -0700
Subject: [PATCH 3/5] arm/dt: tegra: Fix I2C nodes to match board files
In-Reply-To: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
Message-ID: <1321911851-10091-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With board files, all I2C busses run at 400KHz. Fix the device-tree
to be consistent with this. It's possible this is incorrect, but at
least it keeps the board files and device-tree consistent.

Also, disable any I2C controllers that the board files don't register,
also for consistency.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-seaboard.dts  |   16 ++++++++++++++++
 arch/arm/boot/dts/tegra-trimslice.dts |    4 ++++
 arch/arm/boot/dts/tegra-ventana.dts   |   16 ++++++++++++++++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index d1ada26..92da1f1 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -11,6 +11,22 @@
 		reg = < 0x00000000 0x40000000 >;
 	};
 
+	i2c at 7000c000 {
+		clock-frequency = <400000>;
+	};
+
+	i2c at 7000c400 {
+		clock-frequency = <400000>;
+	};
+
+	i2c at 7000c500 {
+		clock-frequency = <400000>;
+	};
+
+	i2c at 7000d000 {
+		clock-frequency = <400000>;
+	};
+
 	serial at 70006300 {
 		clock-frequency = < 216000000 >;
 	};
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index cf8e561..b1aaa45 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -22,6 +22,10 @@
 		clock-frequency = <400000>;
 	};
 
+	i2c at 7000d000 {
+		status = "disable";
+	};
+
 	serial at 70006000 {
 		clock-frequency = < 216000000 >;
 	};
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 1c09485..0f14ee3 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -10,6 +10,22 @@
 		reg = < 0x00000000 0x40000000 >;
 	};
 
+	i2c at 7000c000 {
+		clock-frequency = <400000>;
+	};
+
+	i2c at 7000c400 {
+		clock-frequency = <400000>;
+	};
+
+	i2c at 7000c500 {
+		clock-frequency = <400000>;
+	};
+
+	i2c at 7000d000 {
+		clock-frequency = <400000>;
+	};
+
 	serial at 70006300 {
 		clock-frequency = < 216000000 >;
 	};
-- 
1.7.0.4
