From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 11 Aug 2011 17:25:40 +0200
Subject: [PATCH v2 0/8] Add pdc feature to atmel-mci
In-Reply-To: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1313076348-3065-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 * merge patch 6 and 7.


The purpose of these patches is to merge at91_mci and atmel atmel-mci drivers.
The first one is used only for old atmel mci core and provides the PDC feature.
The second one works with the old core but doesn't provide the PDC feature so
the goal is to implement this feature in order to remove at91_mci.

This new version of the atmel-mci driver detects mci core version at runtime.
Then it knows if we have to use pio, pdc or dma for transfers.

These patches are based on "mmc: atmel-mci: add suspend/resume support" from
Nicolas.


arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
drivers/mmc/host/atmel-mci-regs.h        |  220 +++++----
drivers/mmc/host/atmel-mci.c             |  824 ++++++++++++++++++++----------
include/linux/atmel-mci.h                |    4 +-
include/linux/atmel_pdc.h                |    2 +
5 files changed, 681 insertions(+), 371 deletions(-)
