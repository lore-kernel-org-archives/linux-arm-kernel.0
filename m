From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 2 Mar 2016 09:14:50 +1100
Subject: linux-next: manual merge of the samsung-krzk tree with the arm-soc
 tree
Message-ID: <20160302091450.6b1463bf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Today's linux-next merge of the samsung-krzk tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  efdda175c07f ("arm64: defconfig: add spmi and usb related configs")

from the arm-soc tree and commit:

  617fe7196d54 ("arm64: defconfig: Enable exynos thermal config")
  6bb837189388 ("arm64: defconfig: Enable Samsung MFD and related configs")

from the samsung-krzk tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index 459e96aec818,df8f580b60e0..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -30,11 -31,9 +30,11 @@@ CONFIG_MODULES=
  CONFIG_MODULE_UNLOAD=y
  # CONFIG_BLK_DEV_BSG is not set
  # CONFIG_IOSCHED_DEADLINE is not set
 +CONFIG_ARCH_SUNXI=y
 +CONFIG_ARCH_ALPINE=y
  CONFIG_ARCH_BCM_IPROC=y
  CONFIG_ARCH_BERLIN=y
- CONFIG_ARCH_EXYNOS7=y
+ CONFIG_ARCH_EXYNOS=y
  CONFIG_ARCH_LAYERSCAPE=y
  CONFIG_ARCH_HISI=y
  CONFIG_ARCH_MEDIATEK=y
@@@ -164,11 -147,14 +164,16 @@@ CONFIG_GPIO_XGENE=
  CONFIG_POWER_RESET_XGENE=y
  CONFIG_POWER_RESET_SYSCON=y
  # CONFIG_HWMON is not set
+ CONFIG_THERMAL=y
+ CONFIG_THERMAL_EMULATION=y
+ CONFIG_EXYNOS_THERMAL=y
+ CONFIG_MFD_SEC_CORE=y
 +CONFIG_MFD_SPMI_PMIC=y
  CONFIG_REGULATOR=y
  CONFIG_REGULATOR_FIXED_VOLTAGE=y
  CONFIG_REGULATOR_QCOM_SMD_RPM=y
 +CONFIG_REGULATOR_QCOM_SPMI=y
+ CONFIG_REGULATOR_S2MPS11=y
  CONFIG_FB=y
  CONFIG_FB_ARMCLCD=y
  CONFIG_FRAMEBUFFER_CONSOLE=y
@@@ -215,16 -191,13 +220,17 @@@ CONFIG_LEDS_TRIGGERS=
  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
  CONFIG_LEDS_TRIGGER_CPU=y
  CONFIG_RTC_CLASS=y
+ CONFIG_RTC_DRV_S5M=y
  CONFIG_RTC_DRV_EFI=y
 +CONFIG_RTC_DRV_PL031=y
 +CONFIG_RTC_DRV_SUN6I=y
  CONFIG_RTC_DRV_XGENE=y
  CONFIG_DMADEVICES=y
 -CONFIG_RCAR_DMAC=y
  CONFIG_QCOM_BAM_DMA=y
  CONFIG_TEGRA20_APB_DMA=y
 +CONFIG_RCAR_DMAC=y
 +CONFIG_VFIO=y
 +CONFIG_VFIO_PCI=y
  CONFIG_VIRTIO_PCI=y
  CONFIG_VIRTIO_BALLOON=y
  CONFIG_VIRTIO_MMIO=y
