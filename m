From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Apr 2012 15:12:23 +0100
Subject: [PATCH 0/3] ARM errata fixes for multiple-platform kernels
Message-ID: <1334239946-15934-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series fixes three errata workarounds so that they are only applied
on platforms known to be affected at runtime, since applying them on
other platforms can cause nasty side effects (lockups).

Comments and any tested-bys are more than welcome,

Will


Will Deacon (3):
  ARM: errata: only handle ARM erratum #326103 on affected cores
  ARM: l2x0: only apply workaround for erratum #753970 on PL310
  ARM: l2x0: only write to debug registers on PL310

 arch/arm/Kconfig         |    9 +++++++++
 arch/arm/mm/abort-ev6.S  |   17 +++++++++++------
 arch/arm/mm/cache-l2x0.c |   25 ++++++++++++++-----------
 3 files changed, 34 insertions(+), 17 deletions(-)

-- 
1.7.4.1
