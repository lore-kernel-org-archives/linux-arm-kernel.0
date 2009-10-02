From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  2 Oct 2009 11:14:50 -0700
Subject: [PATCH 0/5] OMAP PM fixes for 2.6.32
Message-ID: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These fixes are primarily for PRCM interrupt handler bugs
and GPIO wakeup support.

Jon Hunter (1):
  OMAP3: PM: Prevent hang in prcm_interrupt_handler

Kevin Hilman (1):
  OMAP3: PM: Enable GPIO module-level wakeups

Paul Walmsley (2):
  OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
  OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts

Vikram Pandita (1):
  OMAP3: PM: USBHOST: clear wakeup events on both hosts

 arch/arm/mach-omap2/pm34xx.c |  187 ++++++++++++++++++++++++------------------
 1 files changed, 106 insertions(+), 81 deletions(-)
