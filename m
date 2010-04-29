From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 29 Apr 2010 10:03:16 +0200
Subject: IMX Watchdog driver for machs MX2 up to MX51
Message-ID: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

here is finally the watchdog driver for MX2 and later. It has been rewritten as
the changes from the last version are major:

- seperation from MX1-driver as discussed with Wim
- added the timer for petting a closed watchdog device
- switching to managed resources
- picking up ideas from Vladimir
- lots of simplification on the way

The MX1-driver is not included in this patchset. Mach-updates to affected machs
are included in this patchset. Some of the naming in there has grown
inconsistently (mxc_wdt vs imx_wdt_device0), but this happened to not only the
watchdog device, so the old names are kept for now, waiting for a general
cleanup-patch.

It has been tested on a mx27 and mx35 board. mx25 and mx51 were build-tested.
checkpatch is happy, too.

Please test, review and consider for inclusion.

Kind regards,

   Wolfram
