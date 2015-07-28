From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 28 Jul 2015 15:00:23 +0800
Subject: [PATCH 0/2] watchdog: at91sam9_wdt: add new feature support
Message-ID: <1438066825-21923-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

Atmel Watchdog Timer has a new feature from SAMA5D4, the Watchdog Timer Mode
Register can be written more than once, so the driver can enable/disable
the watchdog timer hardware and set the watchdog timer hardware timeout.

The patch set is to add new feature.

Wenyou Yang (2):
  drivers: watchdog: at91sam9_wdt: add new feature support
  Documentation: dt: binding: atmel-wdt: add a new compitable

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |    4 +-
 drivers/watchdog/at91sam9_wdt.c                    |  255 ++++++++++++++------
 drivers/watchdog/at91sam9_wdt.h                    |    4 +
 3 files changed, 193 insertions(+), 70 deletions(-)

-- 
1.7.9.5
