From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 25 Jun 2013 10:08:22 +0200
Subject: [PATCH v2 0/4] ARM: at91: prepare transition to common clk framework
Message-ID: <1372147702-4074-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series prepares the transition to common clk framework by
replacing all the clk_enable and clk_disable calls by clk_prepare_unable and
clk_disable_unprepare to avoid common clock framework warnings.

Best Regards,
Boris

Changes since v1:
 - remove unneeded clk_unprepare in mci driver
 - remove already applied patches (ehci, ohci, dma and serial)

Changes since common clk patch series:
 - add clk_prepare_enable return check
 - fix a deadlock in atmel-mci (missing spin_unlock)
 - remove already applied patches (atmel-ssc and pwm-atmel-tcb)

Boris BREZILLON (4):
  ARM: at91/tc/clocksource: replace clk_enable/disable with
    clk_prepare_enable/disable_unprepare.
  mmc: atmel-mci: prepare clk before calling enable
  usb: gadget: at91_udc: prepare clk before calling enable
  at91/avr32/atmel_lcdfb: prepare clk before calling enable

 drivers/clocksource/tcb_clksrc.c |   10 +++++-----
 drivers/mmc/host/atmel-mci.c     |   27 ++++++++++++++++++---------
 drivers/usb/gadget/at91_udc.c    |   14 ++++++++------
 drivers/video/atmel_lcdfb.c      |    8 ++++----
 4 files changed, 35 insertions(+), 24 deletions(-)

-- 
1.7.9.5
