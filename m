From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue,  8 Nov 2016 19:57:35 +0100
Subject: [PATCH 0/3] [PART 2/4] ARM: davinci: OHCI: Use a regulator instead of
 callbacks
Message-ID: <20161108185738.17571-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the ultimate goal to able to probe the ohci driver form DT,
convert users of OHCI pdata to use a regulator instead of
passing platform function pointers. This will help to remove the
platform callbacks in a future series.

DEPENDENCIES:
1. [PATCH 0/3] fix ohci phy name
https://lkml.org/lkml/2016/11/2/208
2. [PATCH/RFC v2 0/3] regulator: handling of error conditions for usb drivers
https://lkml.org/lkml/2016/11/3/188
3. [PATCH v4 0/3] [PART 1/4] USB: ohci-da8xx: Allow a regulator for VBUS and over current

A branch with all the dependencies can be found here:
https://github.com/axelhaslamx/linux-axel/commits/ohci-da8xx-dt-v4

Axel Haslam (3):
  ARM: davinci: da830: Handle vbus with a regulator
  ARM: davinci: hawk: Remove vbus and over current gpios
  ARM: davinci: remove ohci platform usage

 arch/arm/mach-davinci/board-da830-evm.c     | 108 ++++++++++------------------
 arch/arm/mach-davinci/board-omapl138-hawk.c |  99 ++-----------------------
 arch/arm/mach-davinci/include/mach/da8xx.h  |   2 +-
 arch/arm/mach-davinci/usb-da8xx.c           |   3 +-
 4 files changed, 44 insertions(+), 168 deletions(-)

-- 
2.10.1
