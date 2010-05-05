From: Dinh.Nguyen@freescale.com (Dinh Nguyen)
Date: Wed,  5 May 2010 17:56:08 -0500
Subject: PATCHv1 2.6.34-rc6 0/3-Enable usb gadget on freescale mx51 babbage hw
Message-ID: <1273100171-3235-1-git-send-email-Dinh.Nguyen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of 3 patches is part of enabling usb gadget on freescale mx51 babbage hw.

PATCH 1/3
There is a conditional if statement for the usb clock to be 60MHz +/-1kHz in the 
mxc gadget driver, this requirement is not needed on mx51 because the usb core 
is clocked at 66.5MHz or any other frequency that are not multiples of 60MHz.

PATCH 2/3
PLL3 can be used for TVE output and/or USB. No need to turn on a whole PLL 
just for USB. Using PLL2 is a better source for the usb clock.

PATCH 3/3
Defines device structure for gadget on OTG port and registers it in the board file.
Defines the appropriate clock.
Defines KCONFIG option for enabling OTG port for EHCI or Gadget.
Conditionalizes the OTG port for EHCI or Gadget feature.

git diff --stat for all 3 patches:
arch/arm/mach-mx5/board-mx51_babbage.c |   11 +++++++++++
arch/arm/mach-mx5/clock-mx51.c         |    4 +++-
arch/arm/mach-mx5/devices.c            |   12 ++++++++++++
arch/arm/mach-mx5/devices.h            |    1 +
drivers/usb/gadget/fsl_mx3_udc.c       |   14 ++++++++------
drivers/usb/host/Kconfig               |    8 ++++++++
6 files changed, 43 insertions(+), 7 deletions(-)

Thanks,
Dinh Nguyen
