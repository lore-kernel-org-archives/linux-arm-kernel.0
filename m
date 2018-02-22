From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 22 Feb 2018 12:52:31 +0100
Subject: [GIT PULL] Reset controller changes for v4.17
Message-ID: <1519300351.7447.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

Please consider merging this tag for v4.17. It contains level reset
support for Meson8b SoCs, which was already implemented for the newer
Meson GX, removing the distinction between the two families in the
meson-reset driver. Also the ASPEED LPC reset controller is enabled for
AST2400 and AST2500 SoCs by extending the compatibles list in the
simple-reset driver.

regards
Philipp


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.17

for you to fetch changes up to 1d7592f84f92c6344978186fdbe547af044274b5:

  reset: simple: Enable for ASPEED systems (2018-02-20 17:42:29 +0100)

----------------------------------------------------------------
Reset controller changes for v4.17

This enables level resets on Meson8b SoCs. Level resets have been
previously implemented for the newer Meson GX SoCs, so this removes
the distinction between the two families in the meson-reset driver.

Also enables the ASPEED LPC reset controller on ASPEED AST2400 and
AST2500 SoCs, by adding compatibles to the simple-reset driver.

----------------------------------------------------------------
Joel Stanley (2):
      dt-bindings: aspeed-lpc: Add reset controller
      reset: simple: Enable for ASPEED systems

Martin Blumenstingl (1):
      reset: meson: enable level reset support on Meson8b

 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 21 +++++++++++++++++++++
 drivers/reset/Kconfig                              | 10 +++++++---
 drivers/reset/reset-meson.c                        | 22 +++++-----------------
 drivers/reset/reset-simple.c                       |  2 ++
 4 files changed, 35 insertions(+), 20 deletions(-)
