From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  2 Apr 2012 03:20:54 +0200
Subject: [PATCH 0/4] amba: consolidate dynamic allocators
Message-ID: <1333329654-31597-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few platforms allocate amba_device:s dynamically using custom
code. After remembering that Greg said that all devices should be
dynamically allocated I realize that this is a desired design
pattern and we should move the core code to the amba (primecell)
bus layer.

Need help with testing the MXS, Shawn?

Linus Walleij (4):
  amba: add functions to add devices dynamically
  ARM: mxs: factor out dynamic amba device allocator
  ARM: integrator: factor out dynamic amba device allocator
  ARM: ux500: factor out dynamic amba device allocator

 arch/arm/mach-integrator/impd1.c                |   22 +++-------
 arch/arm/mach-mxs/devices-mx23.h                |   11 ++++-
 arch/arm/mach-mxs/devices-mx28.h                |   12 ++++-
 arch/arm/mach-mxs/devices.c                     |   16 -------
 arch/arm/mach-mxs/devices/Makefile              |    1 -
 arch/arm/mach-mxs/devices/amba-duart.c          |   40 ------------------
 arch/arm/mach-mxs/include/mach/devices-common.h |    5 --
 arch/arm/mach-ux500/devices-common.c            |   33 ---------------
 arch/arm/mach-ux500/devices-common.h            |   23 +++++------
 arch/arm/mach-ux500/devices-db8500.h            |    2 +-
 drivers/amba/bus.c                              |   49 +++++++++++++++++++++++
 include/linux/amba/bus.h                        |    8 ++++
 12 files changed, 92 insertions(+), 130 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/devices/amba-duart.c

-- 
1.7.7.6
