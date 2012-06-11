From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 11 Jun 2012 18:47:03 +0200
Subject: [PATCH 0/2] ARM: OMAP2+: Fix errors in PRCM hwmods + wrong clkdm
Message-ID: <1339433225-30042-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Here is the serie to fix wrong clkdm for the PRCM hwmods.

I did revert as well the patch to make the cm_clkdm and prm_clkdm
common since it does not exist on OMAP4.
I do not thinks it exists in OMAP2 and 3 either, and thus that series should
probably be extended with the total removal of these fake clkdm.
I'd like to get your feedback first on this one to go further for OMAP2 & 3.

This series is based on 3.5-rc2 and should target -rc3.

Regards,
Benoit


Benoit Cousson (2):
  ARM: OMAP2+: hwmod data: Fix the wrong clkdm assigned to PRCM modules
  Revert "ARM: OMAP2+: clockdomains: make {prm,cm}_clkdm common"

 arch/arm/mach-omap2/Makefile                     |    1 -
 arch/arm/mach-omap2/clockdomain44xx.c            |    6 ---
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   10 ++++
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 -
 arch/arm/mach-omap2/clockdomains_common_data.c   |   24 ----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c       |   52 +++++++++++-----------
 6 files changed, 36 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c
