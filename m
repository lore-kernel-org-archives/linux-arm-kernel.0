From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 13 Jan 2011 14:14:34 +0100
Subject: [PATCH v2] Add i.MX23/28 auart support
Message-ID: <1294924476-10653-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second version of these patches. I have reworked the driver to
support the NPCK, BRKINT, PARMRK, IGNPAR, IGNBRK and cflag CREAD flags. I have
tested these flags to the best of my knowledge, but it's sometimes hard to
judge if the behaviour is expected.

Sascha


Sascha Hauer (2):
      serial: Add auart driver for i.MX23/28
      ARM MXS: Add auart platform support for i.MX28

 arch/arm/mach-mxs/clock-mx28.c                  |    5 +
 arch/arm/mach-mxs/devices-mx28.h                |    8 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-auart.c      |   54 ++
 arch/arm/mach-mxs/include/mach/devices-common.h |   10 +
 drivers/serial/Kconfig                          |   15 +
 drivers/serial/Makefile                         |    1 +
 drivers/serial/mxs-auart.c                      |  806 +++++++++++++++++++++++
 9 files changed, 903 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-auart.c
 create mode 100644 drivers/serial/mxs-auart.c
