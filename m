From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2016 02:31:51 +0200
Subject: [GIT PULL 4/8] ARM: SoC 64-bit changes for v4.9
In-Reply-To: <3637015.LRn5VyhPVM@wuerfel>
References: <3637015.LRn5VyhPVM@wuerfel>
Message-ID: <6697867.ecXgajhiod@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:

  Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-arm64

for you to fetch changes up to a119a2c4c093716193574675590ea4a7835fa277:

  Merge tag 'zte-defconfig64-4.9' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into next/arm64 (2016-09-19 22:35:21 +0200)

----------------------------------------------------------------
ARM: SoC 64-bit changes for v4.9

Changes to platform code for 64-bit ARM platforms.

Nearly all of these are defconfig updates to enable new drivers or old
drivers still used on these 64-bit platforms.

Aside from that, we gain initial support for two set-top-box platforms,
both of which already have 32-bit support in arch/arm:

- Broadcom adds abstract support for the bcm7xxx/brcmstb platform,
  presumably the respective dts files and more information will
  follow at a later point.

- The ZTE ZX296718 SoC for set-top-boxes, a relative of the 32-bit
  ZX296702 SoC that we already support.

----------------------------------------------------------------
Andre Przywara (1):
      arm64: sunxi: Kconfig: add essential pinctrl driver

Arnd Bergmann (8):
      Merge tag 'hisi-defconfig-for-4.9' of git://github.com/hisilicon/linux-hisi into next/arm64
      Merge tag 'qcom-arm64-defconfig-for-4.9' of git://git.kernel.org/.../agross/linux into next/arm64
      Merge tag 'mvebu-defconfig64-4.9-1' of git://git.infradead.org/linux-mvebu into next/arm64
      Merge tag 'renesas-arm64-defconfig-for-v4.9' of git://git.kernel.org/.../horms/renesas into next/arm64
      Merge tag 'arm-soc/for-4.9/soc-arm64' of http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'sunxi-config64-for-4.9' of https://git.kernel.org/.../mripard/linux into next/arm64
      Merge tag 'zte-soc64-4.9' of git://git.kernel.org/.../shawnguo/linux into next/arm64
      Merge tag 'zte-defconfig64-4.9' of git://git.kernel.org/.../shawnguo/linux into next/arm64

Christopher Covington (1):
      arm64: defconfig: Enable QDF2432 config options

Florian Fainelli (1):
      arm64: Add Broadcom Set Top Box Kconfig entry point

Gregory CLEMENT (1):
      arm64: configs: enable PCIe driver for Aardvark

Guodong Xu (3):
      arm64: defconfig: Enable HiSilicon kirin drm, adv7533 for HiKey
      arm64: defconfig: enable CONFIG_INPUT_HISI_POWERKEY for HiKey
      arm64: defconfig: enable bluetooth supports as modules

John Stultz (1):
      Kconfig: ARCH_HISI: Add PINCTRL to HISI platform

Jun Nie (2):
      arm64: defconfig: enable ZTE ZX related config
      arm64: add ZTE ZX SoC family

Kefeng Wang (1):
      arm64: defconfig: Enable Hisi SAS and HNS

Kevin Hilman (4):
      arm64: defconfig: enable HW random as module
      arm64: defconfig: enable meson WDT as modules
      arm64: defconfig: enable meson SPI as module
      arm64: defconfig: enable meson I2C

Leo Yan (1):
      arm64: defconfig: enable common modules for power management

Simon Horman (1):
      arm64: defconfig: Enable SDHI and GPIO_REGULATOR

Thomas Petazzoni (1):
      arm64: defconfig: enable xhci-platform

Yoshihiro Shimoda (1):
      arm64: defconfig: Add Renesas R-Car HSUSB driver support as module

 arch/arm64/Kconfig.platforms | 15 +++++++++++++++
 arch/arm64/configs/defconfig | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)
