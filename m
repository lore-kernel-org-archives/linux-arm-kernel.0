From: Tero.Kristo@nokia.com (Tero.Kristo at nokia.com)
Date: Wed, 2 Mar 2011 08:18:29 +0000
Subject: [PATCH 0/2] OMAP3: cpuidle: prevent CORE pwrdm from entering
	low-power state when DSS active
In-Reply-To: <20110301220833.32613.54669.stgit@twilight.localdomain>
References: <20110301220833.32613.54669.stgit@twilight.localdomain>
Message-ID: <854C6400F5AA6644BA6FE7953F3E769B0380D180@008-AM1MPN1-013.mgdnok.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: ext Paul Walmsley [mailto:paul at pwsan.com]
>Sent: 02 March, 2011 00:49
>To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>Kristo Tero (Nokia-MS/Tampere)
>Subject: [PATCH 0/2] OMAP3: cpuidle: prevent CORE pwrdm from entering
>low-power state when DSS active
>
>This series prevents the OMAP3 CPUIdle code from programming the CORE
>powerdomain to enter any power state lower than ON when the DSS power
>domain
>is ON.  (The assumption is that in this case, the DSS is active, DMA'ing
>lines from RAM and displaying them somewhere.)
>
>Tero, please don't hesitate to comment on the patch from you if I got
>the
>commit message wrong.

Hi Paul,

It looks good to me.


>
>
>- Paul
>
>---
>
>Tero Kristo (1):
>      OMAP3: cpuidle: prevent CORE power domain from going to RET or OFF
>when DSS is on
>
>Paul Walmsley (1):
>      OMAP3: cpuidle: add more details to the DSS-related CORE power
>domain state restriction
>
>
> arch/arm/mach-omap2/cpuidle34xx.c |   36
>++++++++++++++++++++++++++++++++++--
> 1 files changed, 34 insertions(+), 2 deletions(-)
