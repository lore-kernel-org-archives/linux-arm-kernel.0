From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  5 May 2011 12:22:15 +0200
Subject: [PATCH 0/6] drop IRQF_DISABLED from RTC,
	then convert stmp-rtc to mach-mxs
Message-ID: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First, cleanup RTC to remove the deprecated IRQF_DISABLED which is a
nop these days.

Then, because plat-stmp is going to be removed and merged with mxs, this
patch series will convert the stmp-rtc driver for usage with mach-mxs.
Quite some platform-specific dependencies have been removed, so the
driver should be better reusable.

The driver has successfully been tested on an i.MX28-board and passed the RTC
test program.

Regards,

   Wolfram

Wolfram Sang (6):
  rtc: remove IRQF_DISABLED
  rtc: stmp3xxx: get rid of platform-specific register include
  rtc: stmp3xxx: port stmp-functions to mxs-equivalents
  rtc: stmp3xxx: fix crash on boot
  rtc: stmp3xxx: get rid of mach-specific accessors
  rtc: stmp3xxx: remove UIE handlers

 drivers/rtc/Kconfig         |    6 +-
 drivers/rtc/rtc-at91sam9.c  |    3 +-
 drivers/rtc/rtc-cmos.c      |    5 +-
 drivers/rtc/rtc-coh901331.c |    2 +-
 drivers/rtc/rtc-davinci.c   |    2 +-
 drivers/rtc/rtc-ds1511.c    |    2 +-
 drivers/rtc/rtc-ds1553.c    |    2 +-
 drivers/rtc/rtc-lpc32xx.c   |    2 +-
 drivers/rtc/rtc-mpc5121.c   |    4 +-
 drivers/rtc/rtc-mrst.c      |    5 +-
 drivers/rtc/rtc-mv.c        |    3 +-
 drivers/rtc/rtc-nuc900.c    |    2 +-
 drivers/rtc/rtc-omap.c      |    4 +-
 drivers/rtc/rtc-pl030.c     |    3 +-
 drivers/rtc/rtc-pl031.c     |    2 +-
 drivers/rtc/rtc-pxa.c       |    6 +-
 drivers/rtc/rtc-s3c.c       |    4 +-
 drivers/rtc/rtc-sa1100.c    |    4 +-
 drivers/rtc/rtc-sh.c        |    8 +-
 drivers/rtc/rtc-stk17ta8.c  |    3 +-
 drivers/rtc/rtc-stmp3xxx.c  |  150 ++++++++++++++++++++++---------------------
 drivers/rtc/rtc-tx4939.c    |    2 +-
 drivers/rtc/rtc-vr41xx.c    |    4 +-
 23 files changed, 112 insertions(+), 116 deletions(-)

-- 
1.7.2.5
