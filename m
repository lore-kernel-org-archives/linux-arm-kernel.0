From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 13 Nov 2012 10:33:39 +0530
Subject: [PATCH 1/3] ARM: tegra: dts: add sflash controller dt entry
In-Reply-To: <1352783021-25393-1-git-send-email-ldewangan@nvidia.com>
References: <1352783021-25393-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1352783021-25393-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nvidia's Tegra20 have the SPI (SFLASH) controller to
interface with spi flash device which is used for system
boot. Add DT entry for this controller.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 71a650d..32cb09d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -195,6 +195,16 @@
 		status = "disabled";
 	};
 
+	spi at 7000c380 {
+		compatible = "nvidia,tegra20-sflash";
+		reg = <0x7000c380 0x80>;
+		interrupts = <0 39 0x04>;
+		nvidia,dma-request-selector = <&apbdma 11>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	spi at 7000d400 {
 		compatible = "nvidia,tegra20-slink";
 		reg = <0x7000d400 0x200>;
-- 
1.7.1.1
