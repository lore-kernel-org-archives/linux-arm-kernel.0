From: will.deacon@arm.com (Will Deacon)
Date: Wed,  1 Feb 2012 13:52:32 +0000
Subject: [PATCH 0/2] Errata workaround updates
Message-ID: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

After Russell pointed out that we weren't applying an erratum workaround
in all cases that it was required:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082730.html

I went back through the documents for PL310 and Cortex-A9 to check that
what we have in Linux matches the latest workarounds. The only other
issue I found was that the PL310 workaround we have for #727915 (added
by Santosh in 2839e06c ("ARM: 6795/1: l2x0: Errata fix for flush by Way
operation can cause data corrupti") will work only on r3p0, leaving r2p0
broken. If anybody has an r2p0 version of the PL310, they may like to
augment the workaround.

While I was at it, I fixed a couple of Kconfig select statements that
needed updating to identify the correct workaround config option.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Will Deacon (2):
  ARM: errata: update workaround for A9 erratum #743622
  ARM: errata: fix PL310 erratum #753970 workaround selection

 arch/arm/Kconfig               |    2 +-
 arch/arm/mach-ux500/Kconfig    |    2 +-
 arch/arm/mach-vexpress/Kconfig |    2 +-
 arch/arm/mm/proc-v7.S          |    4 +---
 4 files changed, 4 insertions(+), 6 deletions(-)

-- 
1.7.4.1
