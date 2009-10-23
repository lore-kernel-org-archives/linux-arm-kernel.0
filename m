From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 23 Oct 2009 09:58:58 -0700
Subject: [PATCH 00/10] OMAP3: PM: add CPUidle support
Message-ID: <1256317148-25506-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds CPUidle support for OMAP3.  This includes power
states for full-chip retention and full-chip OFF during idle.

This series is based on top of Tony's for-next branch plus
the recently posted off-mode series.

  [PATCH v2 00/32] OMAP3: PM: base off-mode support

This series is also available in my linux-omap-pm repo[1]
as a branch named pm-upstream/pm-cpuidle.

Kevin

Jouni Hogander (1):
  OMAP3: PM: Use pwrdm_set_next_pwrst instead of set_pwrdm_state in
    idle loop

Kalle Jokiniemi (1):
  OMAP3: PM: CPUidle: fix init sequencing

Kevin Hilman (2):
  OMAP3: PM: CPUidle: obey enable_off_mode flag
  OMAP3: PM: CPUidle: check activity for C2, C3, correct accounting

Peter 'p2' De Schrijver (2):
  OMAP3: PM: CPUidle: Add new lower-latency C1 state
  OMAP3: PM: idle: Remove fclk check for idle loop

Rajendra Nayak (2):
  OMAP3: PM: CPUidle: base driver and support for C1-C2
  OMAP3: PM: CPUidle: support retention and off-mode C-states

Sanjeev Premi (1):
  OMAP3: PM: CPUidle: Start C-state definitions from base 0

Tero Kristo (1):
  OMAP3: PM: Added resched check into idle calls

 arch/arm/mach-omap2/Makefile      |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c |  318 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h          |    4 +
 arch/arm/mach-omap2/pm34xx.c      |   55 +------
 4 files changed, 329 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cpuidle34xx.c
