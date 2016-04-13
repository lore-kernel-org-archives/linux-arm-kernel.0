From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 17:29:25 +0800
Subject: [GIT PULL] ARM: i.MX fixes for 4.6
Message-ID: <20160413092924.GO28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.6

for you to fetch changes up to fc26fe9c3869f02dd9dc54ff3a45c6d9d4bbbdfa:

  ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask (2016-04-13 16:41:56 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.6:
 - The sdhci-esdhc-imx DMA support is broken due to commit 7b91369b4655
   ("mmc: sdhci: Set DMA mask when adding host").  It requires device's
   dma_mask be set up properly to get DMA work.  The fixing patch
   initializes the DMA mask to enable the access again.

----------------------------------------------------------------
Alexander Kurz (1):
      ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask

 arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
