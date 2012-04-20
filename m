From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 20 Apr 2012 12:19:43 +0300
Subject: [PATCHv4 0/8] ARM: OMAP4: core retention support
Message-ID: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes compared to previous version:

- rebased on top of 3.4
- added back TEMP patch for preventing DSP wakeup as Paul's powerdomain
  fixes are not yet in (patch #2)
- added open switch retention support (OSWR), can be enabled by
  echo 1 > /debug/pm_debug/enable_oswr_mode
- fixed support for 4460 (added patch #3)

Applies on top of mainline 3.4 + iochain set. May kind of work without
the iochain set but waking up from retention might be impossible.

Tested both CSWR + OSWR modes on omap4430 EMU blaze + omap4460 GP panda.

Working branch available here:
tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.4-omap4-ret

-Tero
