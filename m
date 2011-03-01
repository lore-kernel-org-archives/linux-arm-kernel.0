From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 01 Mar 2011 15:49:18 -0700
Subject: [PATCH 0/2] OMAP3: cpuidle: prevent CORE pwrdm from entering
	low-power state when DSS active
Message-ID: <20110301220833.32613.54669.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series prevents the OMAP3 CPUIdle code from programming the CORE
powerdomain to enter any power state lower than ON when the DSS power domain
is ON.  (The assumption is that in this case, the DSS is active, DMA'ing
lines from RAM and displaying them somewhere.)

Tero, please don't hesitate to comment on the patch from you if I got the
commit message wrong.


- Paul

---

Tero Kristo (1):
      OMAP3: cpuidle: prevent CORE power domain from going to RET or OFF when DSS is on

Paul Walmsley (1):
      OMAP3: cpuidle: add more details to the DSS-related CORE power domain state restriction


 arch/arm/mach-omap2/cpuidle34xx.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)
