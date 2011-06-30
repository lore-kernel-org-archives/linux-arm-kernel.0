From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 30 Jun 2011 12:41:54 +0200
Subject: [PATCH v3] implement a generic PWM framework
Message-ID: <1309430517-23821-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

3rd version. No changes to the core except that I added F: drivers/pwm/ to
MAINTAINERS. Arnd, I looked through the comments to the first series again
and this was the only thing I could find I forgot. You referred to three
things. Is there more I forgot?

What changed though is the mxs pwm driver. I now register a pwm core
device which handles the shared enable register as suggested by Arnd.

Sascha

The following changes since commit b0af8dfdd67699e25083478c63eedef2e72ebd85:

  Linux 3.0-rc5 (2011-06-27 19:12:22 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git pwm

Sascha Hauer (3):
      PWM: add pwm framework support
      ARM mxs: adjust pwm resources to what the driver expects
      pwm: Add a i.MX23/28 pwm driver

 Documentation/pwm.txt                        |   56 +++++
 MAINTAINERS                                  |    6 +
 arch/arm/mach-mxs/devices/platform-mxs-pwm.c |   32 +++-
 drivers/Kconfig                              |    2 +
 drivers/Makefile                             |    1 +
 drivers/pwm/Kconfig                          |   16 ++
 drivers/pwm/Makefile                         |    2 +
 drivers/pwm/core.c                           |  220 ++++++++++++++++++
 drivers/pwm/mxs-pwm.c                        |  312 ++++++++++++++++++++++++++
 include/linux/pwm.h                          |   37 +++
 10 files changed, 681 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/pwm.txt
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/core.c
 create mode 100644 drivers/pwm/mxs-pwm.c
