From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Mar 2015 08:40:35 +0000
Subject: [PATCH 0/2] ARM: imx6: GPC updates after conversion to stacked domains
Message-ID: <1426149637-22062-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series represent the delta between v5 and v6 of the patch
"ARM: imx6: convert GPC to stacked domains".

It allows the kernel to warn loudly when an outdated DT is detected,
and restore the possibility to change the affinity of an interrupt
routed through the GPC.

This of course can only be applied of v5 (v6 contains these changes),
and is posted at Shawn's request.

Thanks,

	M.

Marc Zyngier (2):
  ARM: imx6: Warn when an old DT is detected
  ARM: imx6: Allow GPC interrupts affinity to be changed

 arch/arm/mach-imx/gpc.c     | 15 +++++++++------
 arch/arm/mach-imx/pm-imx6.c |  6 ++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.1.4
