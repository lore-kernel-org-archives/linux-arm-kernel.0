From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 May 2017 23:52:52 -0700
Subject: [GIT PULL 6/7] ARM: SoC 64-bit changes
In-Reply-To: <1494312773-9790-1-git-send-email-olof@lixom.net>
References: <1494312773-9790-1-git-send-email-olof@lixom.net>
Message-ID: <1494312773-9790-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes to platform code for 64-bit ARM platforms.

Most of these are small changes to the one defconfig we use on arm64
(no per-platform configs there), to enable new drivers.

There are also a few other changes. Broadcom sold off their 'Vulcan'
design to Cavium, where it is now called ThunderX2. While we normally
don't rename stuff based on marketing's whims, it seemed appropriate to
bring in renames on a few things such as MAINTAINERS, etc.

----------------------------------------------------------------

The following changes since commit 7ac1dd73f3557a1e9f7601e91c7ea953be9747c7:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-arm64

for you to fetch changes up to 900a9020af7a023f9b64c919fddf8a7486108962:

  arm64: sunxi: always enable reset controller

----------------------------------------------------------------

Andre Przywara (1):
      arm64: defconfig: add Allwinner USB PHY

Antoine Tenart (1):
      arm64: defconfig: enable the Safexcel crypto engine as a module

Arnd Bergmann (4):
      Merge tag 'amlogic-defconfig' of git://git.kernel.org/.../khilman/linux-amlogic into next/arm64
      Merge tag 'mvebu-defconfig64-4.12-1' of git://git.infradead.org/linux-mvebu into next/arm64
      Merge tag 'arm-soc/for-4.12/defconfig-arm64' of http://github.com/Broadcom/stblinux into next/arm64
      arm64: sunxi: always enable reset controller

Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-64-next-2017-03-21' into defconfig-arm64/next

Gerd Hoffmann (1):
      arm64: set CONFIG_MMC_BCM2835=y in defconfig

Gregory CLEMENT (3):
      arm64: defconfig: enable MVNETA
      arm64: defconfig: enable I2C_PXA
      arm64: configs: enable SDHCI driver for Xenon

Icenowy Zheng (1):
      arm64: only select PINCTRL for Allwinner platforms

Jayachandran C (1):
      MAINTAINERS: Broadcom Vulcan is now Cavium ThunderX2

Krzysztof Kozlowski (2):
      arm64: exynos: Enable Exynos PMU and PM domains drivers
      arm64: defconfig: Enable video, DRM and LPASS drivers for Exynos5433 and Exynos7

Martin Blumenstingl (1):
      ARM64: defconfig: enable the leds-pwm driver and default-on trigger

Olof Johansson (4):
      Merge tag 'renesas-arm64-defconfig-for-v4.12' of https://git.kernel.org/.../horms/renesas into next/arm64
      Merge tag 'sunxi-config64-for-4.12' of https://git.kernel.org/.../sunxi/linux into next/arm64
      Merge tag 'samsung-soc64-4.12' of git://git.kernel.org/.../krzk/linux into next/arm64
      Merge tag 'mvebu-defconfig64-4.12-2' of git://git.infradead.org/linux-mvebu into next/arm64

Simon Horman (1):
      arm64: defconfig: Enable SH Mobile I2C controller

Thomas Petazzoni (1):
      arm64: defconfig: enable MVPP2


 MAINTAINERS                  |  9 +--------
 arch/arm64/Kconfig.platforms |  5 ++++-
 arch/arm64/configs/defconfig | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 9 deletions(-)
