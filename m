From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 16 Jan 2012 15:52:35 +0530
Subject: [PATCH 0/5] uart updates 
Message-ID: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch series does the following

- Make the Make the suspend/resume functions depend on
    CONFIG_PM_SLEEP
- Fix the serial omap probe's error handling 
- Make he context_loss_cnt signed so that error handling is 
 possible.


Shubhrajyoti D (5):
  omap-serial :Make the suspend/resume functions depend on
    CONFIG_PM_SLEEP.
  omap-serial: make serial_omap_restore_context depend on
    CONFIG_PM_RUNTIME
  omap-serial: Fix the error handling in the omap_serial probe
  ARM : OMAP : serial : Make context_loss_cnt signed
  OMAP : serial : Check for error in get_context_loss_count

 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
 drivers/tty/serial/omap-serial.c              |   41 ++++++++++++++++--------
 2 files changed, 28 insertions(+), 15 deletions(-)
