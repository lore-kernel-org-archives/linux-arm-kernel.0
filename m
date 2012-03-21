From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 21 Mar 2012 23:21:56 +0100
Subject: [PATCH V2 0/3] introduce stmp-style devices
Message-ID: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes support for a certain type of devices mach independant. We
want that because such devices (having a special register layout) have been
found in mach-mxs and mach-mx6 meanwhile. Please refer to patch 1/3 for a more
detailed description.

Patch 1/3 adds the basic support and is of main interest to get upstream.
Patches 2/3 and 3/3 are usage examples and will be send to the relevant
subsystems once the basic support is accepted.

Main changes since the V1:

* moved stmp_device.c from drivers/base to lib/

Main changes since the RFC:

* renamed the macros to STMP_OFFSET_*
* rebased to 3.3-rc6

Tested with a TX28 board.

Thanks,

   Wolfram

Wolfram Sang (3):
  lib: add support for stmp-style devices
  i2c: mxs: use global reset function
  rtc: stmp3xxx: use global stmp_device functionality

 drivers/i2c/busses/Kconfig   |    1 +
 drivers/i2c/busses/i2c-mxs.c |    9 +----
 drivers/rtc/Kconfig          |    1 +
 drivers/rtc/rtc-stmp3xxx.c   |   29 +++++----------
 include/linux/stmp_device.h  |   20 ++++++++++
 lib/Kconfig                  |    3 ++
 lib/Makefile                 |    2 +
 lib/stmp_device.c            |   80 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 119 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/stmp_device.h
 create mode 100644 lib/stmp_device.c

-- 
1.7.2.5
