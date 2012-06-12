From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 12 Jun 2012 18:31:15 +0300
Subject: [PATCHv3 00/20] ARM: OMAP4: device off support
Message-ID: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

V3 consists of following changes:

- ordering of patches changed (enable off-mode as last patch)
- rebased on top of 3.5-rc2
- rebased on top of Jean Pihet's functional power state code
- omap-secure driver has now its own CPU PM notifier:
  * moved dummy wakeup dispatcher call from omap-mpuss-lowpower.c
  * moved secure dispatcher calls from omap-wakeupgen.c
- device off mode is now enabled (in addition to previously just been
  traced) as a functional OFF state for core power domain
- added lots of kerneldoc comments
- dropped dpll_dump functionality from dpll44xx.c
- disabled device-off mode for early omap4430 GP chips (due to bugs
  impossible to support this mode on them)
- a number of other minor changes

Working tree available here:
tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.5-rc2-omap4-dev-off-v3

This tree is based on top of omap4 core retention tree.

Tested with omap4 panda es board (4460 GP) and omap4 blaze board (4430 EMU.)

-Tero
