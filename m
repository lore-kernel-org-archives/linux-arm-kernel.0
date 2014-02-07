From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 7 Feb 2014 15:51:22 +0530
Subject: [PATCH V2 0/4] ARM: OMAP2+: AM43x: Enable in OMAP2PLUS and add ID for
 ES1.1
Message-ID: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables AM43xx SOC in omap2plus_deconfig along with
updating clocksource and adding support for ES1.1.
With this series using omap2plus_defconfig alone boots on AM43XX.

Changes since V1:
- Added a new patch to determine AM43x device features.

Tested on: 
AM4372 EPOS EVM. log for the same http://hastebin.com/pagigecume.xml

Afzal Mohammed (2):
  ARM: OMAP2+: AM43x: enable in default config
  ARM: OMAP2+: AM43x: determine features

Lokesh Vutla (1):
  ARM: OMAP2+: AM43x: Add ID for ES1.1

Rajendra Nayak (1):
  ARM: OMAP2+: AM43x: Use gptimer as clocksource

 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/board-generic.c  |    2 +-
 arch/arm/mach-omap2/id.c             |   16 ++++++++++++++--
 arch/arm/mach-omap2/io.c             |    1 +
 arch/arm/mach-omap2/soc.h            |    3 ++-
 arch/arm/mach-omap2/timer.c          |    3 ++-
 6 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.7.9.5
