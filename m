From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Fri, 9 Nov 2018 01:54:33 +0100
Subject: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
Message-ID: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ARM maintainers,

v3: Keep CRYPTO_DEV_FSL_DPAA2_CAAM in patch 7/9

v2: Improve commit message for a few patches

The set of Kconfig options slowly changes with every kernel version.
This patch series regenerates the arm64 defconfig for v4.20
No functional change intended, except adding PINCTRL_MTK_MOORE to
keep PINCTRL_MT7622, and adding FSL_MC_BUS and FSL_MC_DPIO to
keep CRYPTO_DEV_FSL_DPAA2_CAAM.

Marc Gonzalez (9):
  arm64: defconfig: Regenerate for v4.20
  arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
  arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
  arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
  arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
  arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
  arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
  arm64: defconfig: Change SCSI_UFS_HISI=m
  arm64: defconfig: Drop redundant sound codec options

 arch/arm64/configs/defconfig | 108 ++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 59 deletions(-)

-- 
2.8.2
