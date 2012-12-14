From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 14 Dec 2012 15:30:27 +0100
Subject: [PATCH 0/2] mmc: mmci: Update regulator support
Message-ID: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

In this patchset the mmci driver is converted to use the new
mmc_regulator_get_supply API for handling regulators and OCR
mask.

On top of that we are taking the first step of moving away
from using the platform callback, ios_handler, to be more
DT compliant.

Lee Jones (1):
  mmc: mmci: Move ios_handler functionality into the driver

Ulf Hansson (1):
  mmc: mmci: Convert to use mmc_regulator_get_supply

 drivers/mmc/host/mmci.c |   63 +++++++++++++++--------------------------------
 drivers/mmc/host/mmci.h |    1 -
 2 files changed, 20 insertions(+), 44 deletions(-)

-- 
1.7.10
