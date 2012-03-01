From: jason@lakedaemon.net (Jason Cooper)
Date: Thu,  1 Mar 2012 18:20:51 +0000
Subject: [PATCH 0/4] ARM: kirkwood: fdt: convert kirkwood init funcs to fdt
Message-ID: <cover.1330625877.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series begins the process of converting all of the drivers initialized
from kirkwood_init() to devicetree.

The first patch cleans up kirkwood_init() by moving a flag setting to it's
appropriate location.  This will help later when converting the audio driver.

Next, I pull the functionality of kirkwood_init() into kirkwood_dt_init() in
board-dt.c  This way, as drivers are converted, their init calls can be removed
from kirkwood_dt_init() and non-fdt users won't be affected (they call
kirkwood_init()).

Last, I converted the two easiest drivers, rtc and wdt.  The xor and crypto
drivers remain for a later patch series.

Jason Cooper (4):
  ARM: kirkwood: move var setting to correct location.
  ARM: kirkwood: fdt: absorb kirkwood_init()
  ARM: kirkwood: convert rtc-mv to fdt.
  ARM: kirkwood: convert orion-wdt to fdt.

 arch/arm/boot/dts/kirkwood.dtsi   |   12 ++++++++++
 arch/arm/mach-kirkwood/board-dt.c |   28 ++++++++++++++++++++++-
 arch/arm/mach-kirkwood/common.c   |   10 ++++----
 arch/arm/mach-kirkwood/common.h   |    6 +++++
 drivers/rtc/rtc-mv.c              |   19 ++++++++++++++++
 drivers/watchdog/orion_wdt.c      |   44 ++++++++++++++++++++++++++----------
 6 files changed, 101 insertions(+), 18 deletions(-)

-- 
1.7.3.4
