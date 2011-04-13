From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 13 Apr 2011 18:21:05 +0300
Subject: [PATCH 0/2] Couple of fixes regarding CM_AUTOIDLE_PLL register
Message-ID: <1302708067-8226-1-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello guys,

This patch set is fixing the saving and restore of CM_AUTOIDLE_PLL register.
It also includes a patch to save and restore it in kernel side, because
ROM code adds extra delay when we use it to restore this register.

Cheers,

Eduardo Valentin (2):
  OMAP2+: PM: Fix the saving of CM_AUTOIDLE_PLL register on scratchpad
    area
  OMAP3: PM: Do not rely on ROM code to restore
    CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL

 arch/arm/mach-omap2/cm2xxx_3xxx.c |   17 +++++++++++++++++
 arch/arm/mach-omap2/control.c     |    8 +++++++-
 2 files changed, 24 insertions(+), 1 deletions(-)

-- 
1.7.5-rc1
