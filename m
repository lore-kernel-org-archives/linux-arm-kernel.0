From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Jan 2014 19:27:15 +0000
Subject: [PATCH V3 2/2] ARM: multi_v7_defconfig: add mvebu drivers
In-Reply-To: <9609875ac4d1bd7d628bd994e0646340d78e423d.1390936638.git.jason@lakedaemon.net>
References: <1390871129-4838-1-git-send-email-jason@lakedaemon.net>
 <9609875ac4d1bd7d628bd994e0646340d78e423d.1390936638.git.jason@lakedaemon.net>
Message-ID: <8a95aff6b85c8974e3e5cfea0b0765b3a9bedc80.1390936638.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent boot farm testing has highlighted some issues with mvebu and
multiplatform kernels.  Increase the test coverage so we can discover
these issues earlier.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
v2 -> v3:
 - rebase onto arm-soc/for-next so arm-soc can apply directly for v3.14-rcX

v1 -> v2:
 - split into two patches, update and +mvebu

 arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1f3649d94bbb..ef877c44cd21 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -57,6 +57,7 @@ CONFIG_ARCH_ZYNQ=y
 CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
+CONFIG_PCI_MVEBU=y
 CONFIG_PCI_TEGRA=y
 CONFIG_HIGHPTE=y
 CONFIG_CMA=y
@@ -108,11 +109,13 @@ CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_SUN4I_EMAC=y
 CONFIG_NET_CALXEDA_XGMAC=y
+CONFIG_MVNETA=y
 CONFIG_KS8851=y
 CONFIG_R8169=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
 CONFIG_TI_CPSW=y
+CONFIG_MARVELL_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_USBNET=y
@@ -155,10 +158,12 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
 CONFIG_SPI_OMAP24XX=y
+CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_SIRF=y
 CONFIG_SPI_TEGRA114=y
@@ -177,6 +182,8 @@ CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_LM90=y
+CONFIG_THERMAL=y
+CONFIG_ARMADA_THERMAL=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
@@ -245,6 +252,7 @@ CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_MMC_MVSDIO=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_HIGHBANK_MC=y
@@ -259,9 +267,11 @@ CONFIG_RTC_DRV_TPS65910=y
 CONFIG_RTC_DRV_EM3027=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_VT8500=y
+CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
+CONFIG_MV_XOR=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_STE_DMA40=y
 CONFIG_SIRF_DMA=y
-- 
1.8.5.3
