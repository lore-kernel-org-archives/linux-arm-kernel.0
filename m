From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 17 Feb 2010 18:02:23 -0600
Subject: [PATCH 0/7] OMAP PM updates for 2.6.34
Message-ID: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a small series of PM updates destined for 2.6.34.

This branch is also available as 'pm-2.6.34' in my tree and is based
on Tony's omap-for-linus branch. This will be it for PM patches for
2.6.34 as the rest of the PM branch is under more significant rework.

Yes, this is a bit late, but hopefully better late than never for
these relatively minor changes.  Thes changes mainly affect CPUidle
and off-mode support, neither of which are currently enbled in
mainline default defconfigs.

Kalle Jokiniemi (2):
  OMAP3: cpuidle: Add valid field into C-state parameter passing
  OMAP3: RX-51: Pass cpu idle parameters

Kevin Hilman (2):
  OMAP3: cpuidle: configure latencies/thresholds from board file
  OMAP3: RX-51: support sleep indicator LEDs

Rajendra Nayak (1):
  OMAP3: PM: add scratchpad locking function

Sanjeev Premi (1):
  OMAP3: cpuidle: Update statistics for correct state

Tero Kristo (1):
  OMAP3: PM: Added support for L2 aux ctrl register save and restore

 arch/arm/mach-omap2/board-3430sdp.c |   20 +++
 arch/arm/mach-omap2/board-rx51.c    |   44 +++++++
 arch/arm/mach-omap2/cpuidle34xx.c   |  226 +++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/pm.h            |   20 +++
 arch/arm/mach-omap2/pm34xx.c        |    4 +
 arch/arm/mach-omap2/sleep34xx.S     |   59 +++++++++-
 arch/arm/plat-omap/Kconfig          |   17 +++
 7 files changed, 352 insertions(+), 38 deletions(-)
