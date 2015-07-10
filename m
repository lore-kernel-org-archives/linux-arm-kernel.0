From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Jul 2015 15:45:40 -0700
Subject: [PATCH 0/7] Remove clk.h from clk-provider.h (ARM part)
Message-ID: <1436568347-24554-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first set in a series of patches that removes
clk.h from clk-provider.h. This allows us to clearly see what
provider drivers are using the consumer API (clk.h) by
checking the includes. Currently clk.h is included by
clk-provider.h even though it doesn't need to so quite a few
clk provider drivers are relying on the implicit include.

Stephen Boyd (7):
  ARM: at91: Remove clk-provider.h include
  ARM: hisi: Remove clk-provider.h include
  ARM: keystone: Remove clk-provider.h include
  ARM: mvebu: Remove clk-provider.h include
  ARM: orion5x: Remove clk-provider.h include
  ARM: s3c64xx: Remove clk-provider.h include
  ARM: OMAP2+: Include clk.h

 arch/arm/mach-at91/at91rm9200.c    | 1 -
 arch/arm/mach-hisi/hisilicon.c     | 1 -
 arch/arm/mach-keystone/pm_domain.c | 1 -
 arch/arm/mach-mvebu/board-v7.c     | 1 -
 arch/arm/mach-omap2/clock.c        | 1 +
 arch/arm/mach-omap2/omap_hwmod.c   | 1 +
 arch/arm/mach-omap2/pm24xx.c       | 1 +
 arch/arm/mach-orion5x/board-dt.c   | 1 -
 arch/arm/mach-s3c64xx/common.c     | 1 -
 9 files changed, 3 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
