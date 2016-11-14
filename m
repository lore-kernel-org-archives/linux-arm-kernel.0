From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 14 Nov 2016 15:04:39 -0800
Subject: [PATCH 0/2] ARM: davinci: cleanup and rework PM initializaion
Message-ID: <20161114230441.356-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series removes the fake platform_device used to initialize PM on
legacy davinci platforms, and adds PM support for DT platforms.

Sekhar: the 2nd patch should probably be squashed into the first upon
approval, but was kept separated in order to make the functional
changes in the first patch more readable.

Tested with legacy boot on da850-evm, and DT boot on da850-lcdk.  Used
RTC to wake from suspend-to-RAM: e.g. rtcwake -m mem -s 4 -d /dev/rtc0

Kevin Hilman (2):
  ARM: davinci: PM: rework init, support DT platforms
  ARM: davinci: PM: rework init: cleanup

 arch/arm/mach-davinci/board-da850-evm.c    | 17 +----
 arch/arm/mach-davinci/board-mityomapl138.c | 16 +----
 arch/arm/mach-davinci/common.c             |  1 -
 arch/arm/mach-davinci/da850.c              | 38 ------------
 arch/arm/mach-davinci/da8xx-dt.c           |  1 +
 arch/arm/mach-davinci/include/mach/da8xx.h |  1 -
 arch/arm/mach-davinci/pm.c                 | 99 +++++++++++++++++-------------
 7 files changed, 58 insertions(+), 115 deletions(-)

-- 
2.9.3
