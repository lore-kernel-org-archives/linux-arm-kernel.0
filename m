From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Oct 2016 08:16:58 -0700
Subject: [PATCH 0/5] Minimal cpuidle fixes for omap5 and dra7
Message-ID: <20161026151703.24730-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some fixes to get minimal cpuidle support working with omap5
and dra7. Not sure if there are still some unsorted issues on enabling
this on dra7, but at least omap5 has been behving for me for few
weeks with these.

Regards,

Tony


Santosh Shilimkar (1):
  ARM: DRA7: PM: cpuidle MPU CSWR support

Tony Lindgren (4):
  ARM: OMAP5: Fix build for PM code
  ARM: OMAP5: Fix mpuss_early_init
  ARM: OMAP4+: Fix bad fallthrough for cpuidle
  ARM: OMAP5: Enable minimal cpuidle for omap5 retention

 arch/arm/mach-omap2/Makefile              |  2 +-
 arch/arm/mach-omap2/cpuidle44xx.c         | 80 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/io.c                  |  3 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 33 +++++++++----
 arch/arm/mach-omap2/omap4-sar-layout.h    |  2 +
 arch/arm/mach-omap2/pm44xx.c              |  2 +-
 6 files changed, 108 insertions(+), 14 deletions(-)

-- 
2.9.3
