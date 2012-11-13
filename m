From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Nov 2012 12:23:53 -0700
Subject: [PATCH] ARM: tegra: trimslice: enable SPI flash
Message-ID: <1352834633-1426-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

TrimSlice contains a 1MiB SPI flash. Represent this in the device tree.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-trimslice.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 27fb8a6..f4e0428 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -254,6 +254,16 @@
 		clock-frequency = <400000>;
 	};
 
+	spi at 7000c380 {
+		status = "okay";
+		spi-max-frequency = <48000000>;
+		spi-flash at 0 {
+			compatible = "winbond,w25q80bl";
+			reg = <0>;
+			spi-max-frequency = <48000000>;
+		};
+	};
+
 	i2c at 7000c400 {
 		status = "okay";
 		clock-frequency = <400000>;
-- 
1.7.0.4
