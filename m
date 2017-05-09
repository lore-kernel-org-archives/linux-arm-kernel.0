From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 May 2017 23:52:50 -0700
Subject: [GIT PULL 4/7] ARM: SoC defconfig updates
In-Reply-To: <1494312773-9790-1-git-send-email-olof@lixom.net>
References: <1494312773-9790-1-git-send-email-olof@lixom.net>
Message-ID: <1494312773-9790-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've traditionally kept defconfig updates in a separate branch, often to
encourage submaintainers to handle those patches separately to avoid conflicts
on the shared files. The amount of changes seem to be decreasing though, so
we might rethink how we handle this going forward.

There really isn't much to write about here. The bulk of changes here
are enabling drivers for whatever platforms the hardware is found on
(and multi-configs).

----------------------------------------------------------------

The following changes since commit 7c58bab1efbfabd487601d0453268dbe9c74b14b:

  Merge tag 'armsoc-dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to ad8618cb9c2e948b3607f3e0a20ee0fe2707d9ae:

  Merge tag 'aspeed-4.12-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed into next/defconfig

----------------------------------------------------------------

Alexandre TORGUE (2):
      ARM: configs: stm32: Set CPU_V7M_NUM_IRQ to max value
      ARM: configs: Add new config fragment to change RAM start point

Arnd Bergmann (3):
      Merge tag 'davinci-for-v4.12/defconfig' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'arm-soc/for-4.12/defconfig' of http://github.com/Broadcom/stblinux into next/defconfig
      multi_v7_defconfig: make Rockchip DRM drivers built-in

Bartosz Golaszewski (3):
      ARM: davinci_all_defconfig: enable VPIF display modules
      ARM: davinci_all_defconfig: enable IRQ support for pca953x
      ARM: omap2plus_defconfig: enable ahci-dm816 module

C?dric Le Goater (1):
      ARM: aspeed: Add CONFIG_SPI_ASPEED_SMC

Dave Gerlach (1):
      ARM: omap2plus_defconfig: Enable support for ti-cpufreq

David Lechner (1):
      ARM: davinci_all_defconfig: Enable TI ADS7950

Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2017-03-21' into defconfig/next

Gerd Hoffmann (1):
      arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig and multi_v7_defconfig

Heiko Stuebner (1):
      multi_v7_defconfig: make Rockchip usb2-phy built-in

Jagan Teki (2):
      ARM: imx_v6_v7_defconfig: Select max11801_ts touchscreen driver
      ARM: imx_v6_v7_defconfig: Select hid-multitouchdriver

Jia Jie Ho (1):
      ARM: socfpga: updates for socfpga_defconfig

Joel Stanley (2):
      ARM: configs: aspeed: Update configs for BMC systems
      ARM: configs: aspeed: Add new drivers

Jonathan Neusch?fer (1):
      ARM: qcom_defconfig: Enable Qualcomm remoteproc and related drivers

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable DYNAMIC_DEBUG and get rid of old ext3

Leonard Crestez (1):
      ARM: imx_v6_v7_defconfig: Select SMSC_PHY

M'boumba Cedric Madianga (1):
      ARM: configs: stm32: Add I2C support

Olof Johansson (9):
      Merge tag 'stm32-defconfig-for-v4.12-1' of git://git.kernel.org/.../atorgue/stm32 into next/defconfig
      Merge tag 'davinci-for-v4.12/defconfig-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'socfpga_defconfig_updates_for_v4.12' of git://git.kernel.org/.../dinguyen/linux into next/defconfig
      Merge tag 'sunxi-defconfig-for-4.12' of https://git.kernel.org/.../sunxi/linux into next/defconfig
      Merge tag 'qcom-defconfig-for-4.12' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'samsung-defconfig-4.12' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'imx-defconfig-4.12' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'omap-for-v4.12/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'aspeed-4.12-defconfig' of git://git.kernel.org/.../joel/aspeed into next/defconfig

Rask Ingemann Lambertsen (4):
      ARM: sunxi_defconfig: Enable AC100 RTC driver
      ARM: multi_v7_defconfig: Switch sunxi RSB driver from module to built-in
      ARM: multi_v7_defconfig: Enable AC100 RTC driver
      ARM: multi_v7_defconfig: Switch AXP20x driver from module to built-in

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable TI Ethernet PHY

Sekhar Nori (1):
      ARM: davinci_all_defconfig: convert to use libata PATA

Shuah Khan (1):
      ARM: exynos_defconfig: Increase CONFIG_CMA_SIZE_MBYTES to 96

Stefan Wahren (1):
      ARM: bcm2835: Enable missing CMA settings for VC4 driver

Tony Lindgren (2):
      ARM: omap2plus_defconfig: Add QMI, ACM and PPP as loadable modules
      ARM: omap2plus_defconfig: Enable droid 4 devices


 arch/arm/configs/aspeed_g4_defconfig    | 112 +++++++++++++++++++++------
 arch/arm/configs/aspeed_g5_defconfig    | 111 ++++++++++++++++++++------
 arch/arm/configs/bcm2835_defconfig      |   5 +-
 arch/arm/configs/davinci_all_defconfig  |  11 ++-
 arch/arm/configs/dram_0xd0000000.config |   1 +
 arch/arm/configs/exynos_defconfig       |   5 +-
 arch/arm/configs/imx_v6_v7_defconfig    |   5 +-
 arch/arm/configs/multi_v7_defconfig     |  21 ++---
 arch/arm/configs/omap2plus_defconfig    |  24 ++++++
 arch/arm/configs/qcom_defconfig         |   7 ++
 arch/arm/configs/socfpga_defconfig      |   1 +
 arch/arm/configs/stm32_defconfig        |   4 +
 arch/arm/configs/sunxi_defconfig        |   2 +
 13 files changed, 240 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/configs/dram_0xd0000000.config
