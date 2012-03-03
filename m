From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 3 Mar 2012 22:14:36 +0100
Subject: [PATCH 0/4] Use clock functions also for clk_h and clk_p on
 S3C2443/2416
Message-ID: <201203032214.36820.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series modifies the clock init in common-s3c2443 to use the
struct clk operations also for clk_p and clk_h whose values were until
now set statically in s3c24xx_setup_clocks - a function more suited to
the earlier S3C-SoCs.

In the end it makes the code (hopefully) easier to read, as strange
divisions through register values get replaced by simply clk_get_rate
calls.

To apply on top of the current s3c24xx consolidation.

Heiko Stuebner (4):
  ARM: S3C24XX: remove XXX_setup_clocks method from S3C2443
  ARM: S3C24XX: add get_rate for clk_h on S3C2416/2443
  ARM: S3C24XX: add get_rate for clk_p on S3C2416/2443
  ARM: S3C24XX: remove call to s3c24xx_setup_clocks

 arch/arm/mach-s3c24xx/clock-s3c2443.c      |    7 ---
 arch/arm/mach-s3c24xx/common-s3c2443.c     |   70 +++++++++++++++++++---------
 arch/arm/plat-samsung/include/plat/clock.h |    1 -
 3 files changed, 48 insertions(+), 30 deletions(-)

-- 
1.7.2.3
