From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Mar 2013 12:35:06 -0600
Subject: [PATCH] ARM: tegra: fix register address of slink controller
Message-ID: <1363977306-7548-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laxman Dewangan <ldewangan@nvidia.com>

Fix typo on register address of slink3 controller where register
address is wrongly set as 0x7000d480 but it is 0x7000d800.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Arnd, Olof, this is a fix for v3.9.

 arch/arm/boot/dts/tegra20.dtsi |    2 +-
 arch/arm/boot/dts/tegra30.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 48d00a0..3d3f64d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -385,7 +385,7 @@
 
 	spi at 7000d800 {
 		compatible = "nvidia,tegra20-slink";
-		reg = <0x7000d480 0x200>;
+		reg = <0x7000d800 0x200>;
 		interrupts = <0 83 0x04>;
 		nvidia,dma-request-selector = <&apbdma 17>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 9d87a3f..dbf46c2 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -372,7 +372,7 @@
 
 	spi at 7000d800 {
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
-		reg = <0x7000d480 0x200>;
+		reg = <0x7000d800 0x200>;
 		interrupts = <0 83 0x04>;
 		nvidia,dma-request-selector = <&apbdma 17>;
 		#address-cells = <1>;
-- 
1.7.10.4
