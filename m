From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 16:51:47 -0700
Subject: [PATCH 0/2] Fix ir-rx51 by using PWM pdata
Message-ID: <1461714709-10455-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are minimal fixes to get ir-rx51 going again. Then further
fixes can be done as noted in the second patch.

Regards,

Tony


Tony Lindgren (2):
  ARM: OMAP2+: Add more functions to pwm pdata for ir-rx51
  [media] ir-rx51: Fix build after multiarch changes broke it

 arch/arm/mach-omap2/board-rx51-peripherals.c   | 35 ++++++++-
 arch/arm/mach-omap2/pdata-quirks.c             | 33 ++++++++-
 drivers/media/rc/Kconfig                       |  2 +-
 drivers/media/rc/ir-rx51.c                     | 99 ++++++++++++++------------
 include/linux/platform_data/media/ir-rx51.h    |  1 +
 include/linux/platform_data/pwm_omap_dmtimer.h | 21 ++++++
 6 files changed, 141 insertions(+), 50 deletions(-)

-- 
2.8.1
