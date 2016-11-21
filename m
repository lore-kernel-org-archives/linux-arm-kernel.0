From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 17:53:46 +0100
Subject: [RESEND PATCH 0/3] ARM: davinci: OHCI: Use a regulator instead of
 callbacks
Message-ID: <20161121165349.29128-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the ultimate goal to able to probe the ohci driver form DT,
convert users of OHCI pdata to use a regulator instead of
passing platform function pointers. This will help to remove the
platform callbacks in a future series.

These patches were included in previous series[1], im sending them again
to claify that it should go through the devinci tree, and to update
the dependencies. 

[1] https://www.spinics.net/lists/linux-usb/msg148884.html

DEPENDENCIES:

1. [PATCH v6 0/5] USB: ohci-da8xx: Add device tree support
https://lkml.org/lkml/2016/11/21/558

2. [PATCH v3 0/2] regulator: handling of error conditions for usb drivers
https://lkml.org/lkml/2016/11/4/465

3. [PATCH v2 0/3] davinci: ohci: fix usb ohci device name
http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1263999.html

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
2.9.3
