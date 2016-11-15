From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 15 Nov 2016 11:54:18 -0800
Subject: [PATCH v2 0/3] ARM: davinci: PM: cleanup init, add DT support
Message-ID: <20161115195421.19983-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series removes the fake platform_device used to initialize PM on
legacy davinci platforms, and also adds PM support for DT platforms.

Tested with legacy boot on da850-evm, and DT boot on da850-lcdk.  Used
RTC to wake from suspend-to-RAM: e.g. rtcwake -m mem -s 4 -d /dev/rtc0

Changes since v1:
- separated support for DT platfroms into separate patch
- misc. cleanup, re-structuring

Kevin Hilman (3):
  ARM: davinci: PM: rework init, support DT platforms
  ARM: davinci: PM: cleanup: remove references to pdata
  ARM: davinci: PM: support da8xx DT platforms

 arch/arm/mach-davinci/board-da850-evm.c    |  17 +----
 arch/arm/mach-davinci/board-mityomapl138.c |  16 +----
 arch/arm/mach-davinci/common.c             |   1 -
 arch/arm/mach-davinci/da850.c              |  38 -----------
 arch/arm/mach-davinci/da8xx-dt.c           |   1 +
 arch/arm/mach-davinci/include/mach/da8xx.h |   1 -
 arch/arm/mach-davinci/pm.c                 | 102 ++++++++++++++++-------------
 7 files changed, 60 insertions(+), 116 deletions(-)

-- 
2.9.3
