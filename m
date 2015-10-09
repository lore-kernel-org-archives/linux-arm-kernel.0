From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 9 Oct 2015 10:53:49 +0200
Subject: [GIT PULL] MMC fixes for v.4.3 rc5
Message-ID: <CAPDyKFp2D2twO03ncFtOePzCmdx3jYfJ8hr317VAiUDWgbDrZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are some mmc fixes intended for v4.3 rc5 and it's based on v4.3-rc4.
Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.3-rc4

for you to fetch changes up to 88c6eb0e3b81a30514d21679735fa25d028c2299:

  mmc: sdhci-of-at91: use SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST
quirk (2015-10-08 19:55:05 +0200)

----------------------------------------------------------------
MMC host:
 - omap_hsmmc: Fix boot regressions for omap4430
 - omap_hsmmc: Fix legacy boot regression for omap3
 - sdhci-pxav3: Fix some clock issues for Armada 38x
 - sdhci-pxav3: Fix error handling at probe
 - sdhci-of-at91: Fix clock stabilization problem

----------------------------------------------------------------
Marcin Wojtas (1):
      mmc: sdhci-pxav3: fix error handling of armada_38x_quirks

Nadav Haklai (2):
      mmc: sdhci-pxav3: remove broken clock base quirk for Armada 38x
sdhci driver
      mmc: sdhci-pxav3: disable clock inversion for HS MMC cards

Tony Lindgren (2):
      Revert "mmc: host: omap_hsmmc: use regulator_is_enabled to find
pbias status"
      mmc: host: omap_hsmmc: Fix MMC for omap3 legacy booting

ludovic.desroches at atmel.com (2):
      mmc: sdhci: add quirk SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST
      mmc: sdhci-of-at91: use SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST quirk

 drivers/mmc/host/omap_hsmmc.c    | 14 +++++++++-----
 drivers/mmc/host/sdhci-of-at91.c |  1 +
 drivers/mmc/host/sdhci-pxav3.c   |  6 +++++-
 drivers/mmc/host/sdhci.c         |  2 ++
 drivers/mmc/host/sdhci.h         |  5 +++++
 5 files changed, 22 insertions(+), 6 deletions(-)
