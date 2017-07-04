From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jul 2017 16:26:22 +0200
Subject: [GIT PULL 7/7] ARM: SoC 64-bit changes
Message-ID: <CAK8P3a3wjv1QQvOetzEm7oF0iduFbJctRvktJeZh-_YPP5LUxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-arm64

for you to fetch changes up to 96f630279ad49402fa394e145a2c28bd97d6e3c4:

  Merge tag 'actions-arm64-soc-for-4.13' of
git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions
into next/arm64 (2017-06-29 17:19:27 +0200)

----------------------------------------------------------------
ARM: SoC 64-bit changes

Changes to platform code for 64-bit ARM platforms.

Andreas F?rber adds two new platforms with initial code: Realtek RTD1295
and Action Semi S900. Both are fairly similar chips, used mainly in
set-top-boxes, but with other possible applications, and additional
members in the respective product families that could be added in the
future. The code here is fairly minimal, as all the interesting parts
are in device drivers and dts files.

The Broadcom Vulcan platform gets dropped, as no products ever became
available, and Cavium integrated the platform under a new name.

Among some other defconfig changes, Timur Tabi enables a number of
options that are typically required for server platforms.

----------------------------------------------------------------
Andreas F?rber (3):
      ARM64: Prepare Realtek RTD1295
      MAINTAINERS: Add Realtek section
      arm64: Prepare Actions Semi S900

Arnd Bergmann (3):
      Merge tag 'mvebu-arm64-4.13-1' of
git://git.infradead.org/linux-mvebu into next/arm64
      arm64: defconfig: remove duplicate entry
      Merge tag 'actions-arm64-soc-for-4.13' of
git://git.kernel.org/.../afaerber/linux-actions into next/arm64

Florian Fainelli (1):
      arm64: defconfig: Enable ARCH_BRCMSTB

Gregory CLEMENT (1):
      arm64: marvell: enable the Armada 7K/8K pinctrl driver

Jayachandran C (2):
      arm64: disable Broadcom Vulcan platform
      arm64: defconfig: drop ARCH_VULCAN

Kuninori Morimoto (1):
      arm64: defconfig: enable Simple Sound Card support

Neil Armstrong (2):
      ARM64: defconfig: enable IR core, decoders and Meson IR device
      ARM64: defconfig: enable meson SPICC as module

Olof Johansson (4):
      Merge tag 'realtek-arm64-soc-for-4.12' of
git://github.com/afaerber/linux into next/arm64
      Merge tag 'arm-soc/for-4.13/defconfig-arm64' of
http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'amlogic-defconfig' of
git://git.kernel.org/.../khilman/linux-amlogic into next/arm64
      Merge tag 'renesas-arm64-defconfig-for-v4.13' of
https://git.kernel.org/.../horms/renesas into next/arm64

Thomas Petazzoni (1):
      arm64: marvell: enable ICU and GICP drivers

Timur Tabi (8):
      arm64: defconfig: enable ACPI_CPPC_CPUFREQ
      arm64: defconfig: enable BLK_DEV_NVME
      arm64: defconfig: enable EFI_CAPSULE_LOADER
      arm64: defconfig: enable support for PCIe hotplug
      arm64: defconfig: enable APEI and GHES features
      arm64: defconfig: enable EDAC options
      arm64: defconfig: enable QCOM_L2_PMU and QCOM_L3_PMU
      arm64: defconfig: enable Qualcomm Technologies EMAC and some PHY drivers

 MAINTAINERS                  |  7 +++++++
 arch/arm64/Kconfig.platforms | 21 +++++++++++++++++----
 arch/arm64/configs/defconfig | 26 ++++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 6 deletions(-)
