From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  3 Sep 2014 10:45:29 +0200
Subject: [PATCH 0/5] rtc: at91sam9: add DT support
Message-ID: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds DT support to the atmel at91sam9 RTC driver.

It also removes any machine specific inclusions to prepare the migration
to multi platform kernel support, and retain the slow clock to prevent
the CCF from disabling it at the end of boot.

Best Regards,

Boris

Boris BREZILLON (5):
  rtc: at91sam9: remove references to mach specific headers
  rtc: at91sam9: use standard readl/writel functions instead of raw
    versions
  rtc: at91sam9: add DT support
  rtc: at91sam9: retain slow clock and check its rate
  rtc: at91sam9: add DT bindings documentation

 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 20 +++++++
 drivers/rtc/rtc-at91sam9.c                         | 63 +++++++++++++++++++---
 2 files changed, 75 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt

-- 
1.9.1
