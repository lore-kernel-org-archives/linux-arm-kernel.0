From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  4 Dec 2013 15:26:54 -0700
Subject: [PATCH 2/4] ARM: tegra: enable I2C controllers on Venice2
In-Reply-To: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
References: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1386196016-25128-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Enable all the I2C controllers that are wired up on Venice2. I don't
know the correct I2C bus clock rates, so set them all to a conservative
100KHz for now.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 098d0b2081bf..7aa711b7b4e3 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -14,6 +14,31 @@
 		status = "okay";
 	};
 
+	i2c at 7000c000 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000c400 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000c500 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000c700 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000d000 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
 	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
-- 
1.8.1.5
