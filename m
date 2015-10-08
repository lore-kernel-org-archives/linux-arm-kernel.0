From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu,  8 Oct 2015 23:34:28 +0200
Subject: [PATCH 0/6] watchdog: sama5d4 and at91sam9: trivial rework
Message-ID: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A little bit of trivial rework for both sama5d4 and at91sam9 drivers.

Sylvain Rochet (6):
  watchdog: at91sam9: use devm_request_irq instead of request_irq
  watchdog: at91sam9: use watchdog_get_drvdata instead of container_of
  watchdog: at91sam9: rename heartbeats into timeout where necessary
  watchdog: at91sam9: remove nowayout useless copy
  watchdog: at91sam9: remove unused pdata support
  watchdog: sama5d4: try to set timeout from device tree first

 drivers/watchdog/at91sam9_wdt.c | 48 +++++++++++++----------------------------
 drivers/watchdog/sama5d4_wdt.c  |  7 ++++--
 2 files changed, 20 insertions(+), 35 deletions(-)

-- 
2.5.1
