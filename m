From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  6 Jul 2016 22:04:11 -0700
Subject: [GIT PULL 5/4] Broadcom soc-arm64 changes for 4.8 part 2
In-Reply-To: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
References: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1467867851-11298-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9c7a68017503eda3071ba8647bd0b4c716f18c74:

  arm64: vulcan: enable GPIOLIB in Kconfig (2016-05-31 10:52:25 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/soc-arm64-part2

for you to fetch changes up to c4c0e2607abfc86c32a43c9a22b2a256de27dea3:

  Merge tag 'bcm2835-arm64-next-2016-07-03' into soc-arm64/next (2016-07-05 20:49:24 -0700)

----------------------------------------------------------------
This pull requests contains Broadcom ARM64-based SoC changes for 4.8 second part:

- Eric updates the bcm2836 interrupt controller driver not to rely on ARM/Linux specific functions
  in preparation for using it on ARM64

- Eric also adds a Kconfig entry for the BCM2835 Raspberry Pi family in the ARM64 Kconfig.platforms
  file

- Eric cherry picked a patch from Alexander Graf with Acks from ARM64 maintainers to support different
  DMA and bus offsets, required for the Raspberry Pi 3 SoC

----------------------------------------------------------------
Alexander Graf (1):
      arm64: Allow for different DMA and CPU bus offsets

Eric Anholt (3):
      irqchip: bcm2835: Avoid arch/arm-specific handle_IRQ
      Merge remote-tracking branch 'irqchip/irqchip/bcm' into bcm2835-arm64-next
      arm64: Add platform selection for BCM2835.

Florian Fainelli (1):
      Merge tag 'bcm2835-arm64-next-2016-07-03' into soc-arm64/next

 arch/arm64/Kconfig.platforms         | 13 +++++++++++++
 arch/arm64/include/asm/dma-mapping.h | 17 +++++++++++++++--
 drivers/irqchip/irq-bcm2835.c        |  3 +--
 drivers/irqchip/irq-bcm2836.c        |  2 +-
 4 files changed, 30 insertions(+), 5 deletions(-)
