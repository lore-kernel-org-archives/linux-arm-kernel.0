From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 25 May 2011 12:56:48 +0200
Subject: [PATCH V2 0/5] rtc: convert stmp3xxx from plat-stmp to mach-mxs
Message-ID: <1306321013-28364-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

plat-stmp has now been removed and merged with mach-mxs, this patch
series will convert the stmp-rtc driver for usage with mach-mxs, so the
driver will become selectable and usable again (it broke twice after the
UIE conversion, by the way). Quite some platform-specific dependencies
have been removed, too.

The driver has successfully been tested by me on an MX28-board and
passed the RTC test program. Shawn Guo tested it on his MX23 and
MX28 boards.

Change since V1:

* dropped the patch removing IRQF_DISABLED from all other drivers; this
  will be a seperate patch later. I did this for stmp3xxx, though.

* Updated the commit messages

* added Tested-by from Shawn (Thanks!)

I am not sure who is interested in picking these up, Andrew or John? It
is maybe too late for 2.6.40, but I wanted to be sure that plat-stmp is
really removed before resending this series.

Regards,

   Wolfram

Wolfram Sang (5):
  rtc: stmp3xxx: get rid of platform-specific include for register names
  rtc: stmp3xxx: port stmp-functions to mxs-equivalents
  rtc: stmp3xxx: Initialize drvdata before registering device
  rtc: stmp3xxx: get rid of mach-specific accessors
  rtc: stmp3xxx: remove UIE handlers

 drivers/rtc/Kconfig        |    6 +-
 drivers/rtc/rtc-stmp3xxx.c |  152 ++++++++++++++++++++++---------------------
 2 files changed, 81 insertions(+), 77 deletions(-)

-- 
1.7.2.5
