From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 05 Oct 2009 11:02:38 -0700
Subject: [PATCH 0/5] OMAP PM fixes for 2.6.32
In-Reply-To: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
	(Kevin Hilman's message of "Fri\, 2 Oct 2009 11\:14\:50 -0700")
References: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <87r5thwwg1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

If no other review commeents, this series (incluing patch 6) is based
on v2.6.32-rc1 and available for pull.

Kevin

The following changes since commit 17d857be649a21ca90008c6dc425d849fa83db5c:
  Linus Torvalds (1):
        Linux 2.6.32-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-fixes-32

Artem Bityutskiy (1):
      OMAP3: PM: introduce a new powerdomain walk helper

Jon Hunter (1):
      OMAP3: PM: Prevent hang in prcm_interrupt_handler

Kevin Hilman (1):
      OMAP3: PM: Enable GPIO module-level wakeups

Paul Walmsley (2):
      OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
      OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts

Vikram Pandita (1):
      OMAP3: PM: USBHOST: clear wakeup events on both hosts

 arch/arm/mach-omap2/pm-debug.c                |    4 +-
 arch/arm/mach-omap2/pm34xx.c                  |  187 ++++++++++++++-----------
 arch/arm/mach-omap2/powerdomain.c             |   39 ++++--
 arch/arm/plat-omap/include/mach/powerdomain.h |    2 +
 4 files changed, 137 insertions(+), 95 deletions(-)
