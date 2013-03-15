From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sat, 16 Mar 2013 00:25:30 +0530
Subject: [PATCH] ARM: tegra: fix register address of slink controller
Message-ID: <1363373730-10703-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typo on register address of slink3 controller where register
address is wrongly set as 0x7000d480 but it is 0x7000d800.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    2 +-
 arch/arm/boot/dts/tegra30.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 0bfd823..4084da0 100644
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
index c371651..f302ace 100644
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
1.7.1.1
