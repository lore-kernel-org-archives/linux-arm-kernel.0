From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  5 Dec 2013 14:34:45 +0100
Subject: mmc: mxs: Use mmc_of_parse
Message-ID: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a generic mmc_of_parse function. Use it in the mxs-mmc driver
to make the code simpler and to parse some new devicetree propeties.

Sascha

----------------------------------------------------------------
Sascha Hauer (6):
      mmc: Do not call get_cd for non removable cards
      mmc: mxs: use standard flag for non-removable status
      mmc: mxs: use standard flag for broken card detection
      mmc: mxs: use standard flag for cd inverted
      mmc: mxs: use mmc_gpio_get_ro for detecting read-only status
      mmc: mxs: use mmc_of_parse to parse devicetree properties

 drivers/mmc/core/core.c    |  3 ++-
 drivers/mmc/host/mxs-mmc.c | 60 ++++++++++++++--------------------------------
 2 files changed, 20 insertions(+), 43 deletions(-)
