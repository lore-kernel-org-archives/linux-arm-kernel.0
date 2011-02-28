From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 28 Feb 2011 17:40:03 +0100
Subject: [PATCH 0/2] mach-mxs: dynamic device creation for i.MX28-i2c
Message-ID: <1298911205-3070-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently for mx28 only, because the driver submitted for mainline does only
PIOQUEUE which is only available on that cpu. mx23 can be added if support is
available.

Patches are based on imx-for-2.6.39.

Changes since last version:

* dropped mx23-related corrections (not needed now)
* added support for Karo's TX28

Wolfram Sang (2):
  arm: mxs: add i2c-devices for mx28
  arm: mxs: tx28: add i2c bus and connected RTC

 arch/arm/mach-mxs/Kconfig                       |    1 +
 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |   51 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |    9 ++++
 arch/arm/mach-mxs/mach-tx28.c                   |   10 ++++
 7 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-i2c.c

-- 
1.7.2.3
