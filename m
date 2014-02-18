From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 18 Feb 2014 15:06:35 -0700
Subject: [PATCH] ARM: tegra: add SPI flash to Venice2 DT
Message-ID: <1392761195-20643-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Venice2 contains an SPI Flash chip, which contains the bootloader.
Add this to the DT, so the kernel can access it.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 1ad3f334fb16..e71aeb9929b4 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -914,6 +914,16 @@
 		};
 	};
 
+	spi at 7000da00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+		spi-flash at 0 {
+			compatible = "winbond,w25q32dw";
+			reg = <0>;
+			spi-max-frequency = <20000000>;
+		};
+	};
+
 	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
-- 
1.8.1.5
