From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu,  3 Nov 2016 17:03:05 +0100
Subject: [PATCH v2 0/3] davinci: ohci: fix usb ohci device name
Message-ID: <20161103160308.29588-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb ohci clock match is not working because the usb clock
is registered as "ohci" instead of "ohci.0"

But since there is only a single ohci instance, lets pass -1 to
the platform data id parameter and avoid the extra ".0" matching.

while we are fixing this, rename the driver from "ohci" to
"ohci-da8xx" which  is less generic and consistent with other
usb drivers.

changes form v1 -> v2
*Reword commit messages (David Lechner)

Because of the recently accepted patches on the ARM-davinci side,
This patch series is based on:
branch: /v4.10/soc of the linux-davinci tree.

It Depends on two accepted usb patches missing on that branch:
6c21caa USB: OHCI: make ohci-da8xx a separate driver (in next-usb)
6110c42 usb: ohci-da8xx: Remove code that references mach (in linux-next)

A branch with both patches applied + this series can be found here:
https://github.com/axelhaslamx/linux-axel/commits/ti-davinci-ohci-rename


Axel Haslam (3):
  ARM: davinci: da8xx: Fix ohci device name
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
