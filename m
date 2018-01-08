From: ladis@linux-mips.org (Ladislav Michl)
Date: Mon, 8 Jan 2018 16:39:26 +0100
Subject: [PATCH 0/5] Add capture functionality to OMAP pwm driver
Message-ID: <20180108153926.GA3916@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Folowing patchset is based on Keerthy's "v6 omap: dmtimer: Move driver
out of plat-omap" minus last patch which is here corrected.

Keerthy, feel free to pick cleanup/bugfix patches into your serie
if you find it usefull.

Tony, I wanted to do something easy to understand as a base for
event capture interrupt, but either I do not understand hardware,
or it indeed cannot do pulse capture.

Please see comments in the last patch in the serie.

Ladislav Michl (5):
  clocksource: timer-dm: Make unexported functions static
  clocksource: timer-dm: Check prescaler value
  pwm: pwm-omap-dmtimer: Fix frequency when using prescaler
  clocksource: timer-dm: Add event capture
  pwm: pwm-omap-dmtimer: Add capture functionality

 drivers/clocksource/timer-dm.c             | 269 +++++++++++++++++------------
 drivers/pwm/pwm-omap-dmtimer.c             | 200 +++++++++++++++++----
 include/clocksource/dmtimer.h              |  24 ---
 include/linux/platform_data/dmtimer-omap.h |   8 +
 4 files changed, 334 insertions(+), 167 deletions(-)

-- 
2.15.1
