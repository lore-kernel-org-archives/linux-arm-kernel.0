From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Aug 2016 14:39:24 -0700
Subject: [GIT PULL 3/7] ARM: SoC 64-bit changes for v4.8
In-Reply-To: <1470087568-4222-1-git-send-email-olof@lixom.net>
References: <1470087568-4222-1-git-send-email-olof@lixom.net>
Message-ID: <1470087568-4222-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes to platform code for 64-bit ARM platforms.

Nearlt all of these are defconfig updates to enable new drivers or old
drivers still used on these 64-bit platforms.

Added platforms for this release are:

- Broadcom BCM2837
- Renesas R8A7796



Conflicts:

None

----------------------------------------------------------------

The following changes since commit bb7e7cc3d1f576a01ff64fdfe8d2986c29183220:

  Merge branch 'next/soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-arm64

for you to fetch changes up to 7e03e116e7603fa30e150df889e8daccd429facf:

  arm64: remove duplicate PWM entry in defconfig

----------------------------------------------------------------

Alexander Graf (1):
      arm64: Allow for different DMA and CPU bus offsets

Alim Akhtar (1):
      arm64: defconfig: Enable S2MPS11 clock and S3C RTC driver

Andy Gross (1):
      arm: defconfig: Enable PM8941 pwr key

Ard Biesheuvel (1):
      arm64: defconfig: disable plain NEON implementation of AES

Arnd Bergmann (5):
      Merge tag 'mvebu-arm64-4.8-1' of git://git.infradead.org/linux-mvebu into next/arm64
      Merge tag 'arm-soc/for-4.8/soc-arm64-part2' of http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'samsung-defconfig64-4.8' of git://git.kernel.org/.../krzk/linux into next/arm64
      Merge tag 'tegra-for-4.8-arm64-defconfig' of git://git.kernel.org/.../tegra/linux into next/arm64
      arm64: remove duplicate PWM entry in defconfig

Carlo Caione (1):
      ARM64: Kconfig: Select the Amlogic Meson pin controller driver

Chanho Min (1):
      arm64: defconfig: Enable Cadence MACB/GEM support

Eric Anholt (2):
      Merge remote-tracking branch 'irqchip/irqchip/bcm' into bcm2835-arm64-next
      arm64: Add platform selection for BCM2835.

Florian Fainelli (1):
      Merge tag 'bcm2835-arm64-next-2016-07-03' into soc-arm64/next

Gregory CLEMENT (1):
      arm64: marvell: enable Armada 3700 clock drivers

Javi Merino (1):
      arm64: defconfig: enable SENSORS_ARM_SCPI

Kamlakant Patel (1):
      arm64: vulcan: enable GPIOLIB in Kconfig

Kevin Hilman (1):
      arm64: defconfig: enable stmmac and realtek PHY as modules

Krzysztof Kozlowski (2):
      arm64: exynos: Select SOC specific drivers
      arm64: defconfig: Enable more IP blocks for Exynos7 and Exynos5433

Michael Turquette (1):
      arm64: amlogic: select gxbb clk driver

Olof Johansson (7):
      Merge tag 'samsung-soc64-4.8' of git://git.kernel.org/.../krzk/linux into next/arm64
      Merge tag 'amlogic-soc' of git://git.kernel.org/.../khilman/linux-amlogic into next/arm64
      Merge tag 'arm-soc/for-4.8/soc-arm64' of http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'mvebu-defconfig64-4.8-1' of git://git.infradead.org/linux-mvebu into next/arm64
      Merge tag 'juno-defconfig-4.8' of git://git.kernel.org/.../sudeep.holla/linux into next/arm64
      Merge tag 'qcom-arm64-defconfig-for-4.8' of git://git.kernel.org/.../agross/linux into next/arm64
      Merge tag 'renesas-arm64-defconfig-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/arm64

Srinivas Kandagatla (1):
      arm64: defconfig: enable msm8996 pinctrl support

Stephen Boyd (1):
      arm64: defconfig: Enable qcom msm8996 clk drivers

Sudeep Holla (2):
      arm64: defconfig: enable Generic on-chip SRAM driver
      arm64: Kconfig: select PM{,_GENERIC_DOMAINS} for ARCH_VEXPRESS

Takeshi Kihara (1):
      arm64: defconfig: enable Renesas R8A7796 SoC

Thierry Reding (1):
      arm64: Update default configuration

Thomas Petazzoni (1):
      arm64: configs: enable PCIe driver for Armada 7K/8K


 arch/arm64/Kconfig.platforms         | 22 ++++++++++++++
 arch/arm64/configs/defconfig         | 49 ++++++++++++++++++++++++++++++-
 arch/arm64/include/asm/dma-mapping.h | 17 +++++++++--
 3 files changed, 85 insertions(+), 3 deletions(-)
