From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  9 Sep 2014 11:30:29 +0200
Subject: [PATCH v2 0/6] rtc: at91sam9: add DT support
Message-ID: <1410255035-26775-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds DT support to the atmel at91sam9 RTC driver.

It also removes any machine specific inclusions to prepare the migration
to multi platform kernel support, and retain the slow clock to prevent
the CCF from disabling it at the end of boot.

Best Regards,

Boris

Changes since v1:
 - remove non CCF specific case by adding the appropriate clk_lookup
   entries in arch/arm/mach-at91/<soc-name>.c files

Boris BREZILLON (6):
  rtc: at91sam9: remove references to mach specific headers
  rtc: at91sam9: use standard readl/writel functions instead of raw
    versions
  rtc: at91sam9: add DT support
  ARM: at91: add clk_lookup entry for RTT devices
  rtc: at91sam9: use clk API instead of relying on AT91_SLOW_CLOCK
  rtc: at91sam9: add DT bindings documentation

 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 20 +++++++
 arch/arm/mach-at91/at91sam9260.c                   |  2 +
 arch/arm/mach-at91/at91sam9261.c                   |  2 +
 arch/arm/mach-at91/at91sam9263.c                   |  4 ++
 arch/arm/mach-at91/at91sam9g45.c                   |  2 +
 arch/arm/mach-at91/at91sam9rl.c                    |  2 +
 arch/arm/mach-at91/clock.c                         |  2 +-
 arch/arm/mach-at91/clock.h                         |  1 +
 drivers/rtc/rtc-at91sam9.c                         | 63 ++++++++++++++++++----
 9 files changed, 87 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt

-- 
1.9.1
