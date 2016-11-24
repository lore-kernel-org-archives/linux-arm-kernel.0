From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 24 Nov 2016 16:28:28 +0100
Subject: [PATCH v2 0/3] ARM: davinci: OHCI: Use a regulator instead of
 callbacks
Message-ID: <20161124152831.26678-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert users of OHCI pdata to use a regulator instead of
passing platform function pointers. This will help to remove the
ohci platform callbacks in a future series.

Changes form v1->v2
* Add function name and error number in error path print (Sekhar)

Dependencies:
1. [PATCH v7 0/5] USB: ohci-da8xx: Add device tree support
https://lkml.org/lkml/2016/11/23/557

2. [PATCH v3 0/2] regulator: handling of error conditions for usb drivers
https://lkml.org/lkml/2016/11/4/465

Axel Haslam (3):
  ARM: davinci: da830: Handle vbus with a regulator
  ARM: davinci: hawk: Remove vbus and over current gpios
  ARM: davinci: remove ohci platform usage

 arch/arm/mach-davinci/board-da830-evm.c     | 109 ++++++++++------------------
 arch/arm/mach-davinci/board-omapl138-hawk.c |  99 +------------------------
 arch/arm/mach-davinci/include/mach/da8xx.h  |   2 +-
 arch/arm/mach-davinci/usb-da8xx.c           |   3 +-
 4 files changed, 45 insertions(+), 168 deletions(-)

-- 
2.9.3
