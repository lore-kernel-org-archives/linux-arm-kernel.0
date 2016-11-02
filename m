From: ahaslam@baylibre.com (Axel Haslam)
Date: Wed,  2 Nov 2016 13:44:32 +0100
Subject: [PATCH 0/3] fix ohci phy name
Message-ID: <20161102124435.31777-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb ohci clock match is not working because the usb clock
is registered as "ohci" instead of "ohci.0"

But since there is only a single ohci instance, lets pass -1 to
the platform data id parameter and avoid the extra ".0" matching.

while we are fixing this, rename the driver to "ohci-da8xx" to be
consistent with davinci musb and other usb drivers.

Axel Haslam (3):
  ARM: davinci: da8xx: Fix ohci driver name
  phy: da8xx-usb: rename the ohci device to ohci-da8xx
  usb: ohci-da8xx: rename driver to ohci-da8xx

 arch/arm/mach-davinci/da830.c     | 2 +-
 arch/arm/mach-davinci/da850.c     | 2 +-
 arch/arm/mach-davinci/da8xx-dt.c  | 2 +-
 arch/arm/mach-davinci/usb-da8xx.c | 4 ++--
 drivers/phy/phy-da8xx-usb.c       | 5 +++--
 drivers/usb/host/ohci-da8xx.c     | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.10.1
