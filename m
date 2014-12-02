From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  2 Dec 2014 16:05:24 +0000
Subject: [PATCH v2 0/2] ARM: imx: fix irq_data usage
Message-ID: <1417536326-18691-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX has a fairly creative usage of irq_data, which turns into a
disaster in -next (boards don't even boot).

These two patches are addressing the most pressing issues, and should
be merged as early as possible (we've merged a similar patch for tegra
in 3.18-rc7).

Thanks,

	M.

>From v1: added provided tags.

Marc Zyngier (2):
  ARM: imx: irq: fix buggy usage of irq_data irq field
  ARM: imx6: fix bogus use of irq_get_irq_data

 arch/arm/mach-imx/common.h  |  4 ++--
 arch/arm/mach-imx/gpc.c     | 42 ++++++++++++++++++++++++++----------------
 arch/arm/mach-imx/pm-imx6.c |  5 ++---
 3 files changed, 30 insertions(+), 21 deletions(-)

-- 
2.1.3
