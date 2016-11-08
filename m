From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue,  8 Nov 2016 19:57:50 +0100
Subject: [PATCH 0/2] [PART 3/4] USB: ohci-da8xx: Remove platform callbacks
Message-ID: <20161108185752.17621-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no more users of the platform callbacks as
all of them have been converted to use a regulator.

We can now remove the plafrom callbacks from the driver and the platform
data structure.

DEPENDENCIES:
1. [PATCH 0/3] fix ohci phy name
https://lkml.org/lkml/2016/11/2/208
2. [PATCH/RFC v2 0/3] regulator: handling of error conditions for usb drivers
https://lkml.org/lkml/2016/11/3/188
3. [PATCH v4 0/3] [PART 1/4] USB: ohci-da8xx: Allow a regulator for VBUS and over current
4. [PATCH 0/3] [PART 2/4] ARM: davinci: OHCI: Use a regulator instead of callbacks

A branch with all the dependencies can be found here:
https://github.com/axelhaslamx/linux-axel/commits/ohci-da8xx-dt-v4

Axel Haslam (2):
  USB: ohci: da8xx: Remove ohci platform callbacks
  USB: ohci: da8xx: use a flag instead of mask for ocic

 drivers/usb/host/ohci-da8xx.c             | 101 ++++--------------------------
 include/linux/platform_data/usb-davinci.h |  20 ------
 2 files changed, 12 insertions(+), 109 deletions(-)

-- 
2.10.1
