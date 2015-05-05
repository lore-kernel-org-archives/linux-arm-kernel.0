From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 5 May 2015 16:33:03 +0300
Subject: [PATCH 0/2] ARM: AM43xx: PRM: fix reset handling issues
Message-ID: <1430832785-1976-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The work done for consolidating PRM code introduced a reset issue
on AM43xx which is visible at least with wkup-m3, and prevents
taking the wkup-m3 core out from reset. Fixed by passing all the
relevant PRCM data from hwmod data, which was previously partly
omitted on OMAP4+ case.

This set also removes some redundant AM33xx hwmod code and just
re-uses the OMAP4+ version of the same.

Thanks to Dave Gerlach and Anna Suman for reporting this. Dave, care
to give this patch set a try to see if it fixes the problem you see?

Testing done:
- am335x-bone: boot
- am437x-gp-evm: boot
- omap4-panda-es: boot, suspend/resume, cpuidle

-Tero
