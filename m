From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Jun 2011 12:02:46 +0200
Subject: [RFC] implement a generic PWM framework - once again
Message-ID: <1309255368-9775-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The following implements a generic pwm framework and adds a user
for it. I already posted this series back in January. Based on
the comments I received I added some details about the motivation
for adding such a framework and not using the led or hwmon framework
to patch 1/2.
I also added some documentation to Documentation/pwm.txt.

This patch does not change the user API for PWMs, in particular
it does not enforce any sleep/nonsleep context to the PWM users.
The patch merely puts the status quo into a core wrapper to be able
to register multiple PWM drivers in the system. Improvements to
the API can still be made later once we have at least a place
in the kernel to collect the existing PWM drivers.

Sascha

The following changes since commit b0af8dfdd67699e25083478c63eedef2e72ebd85:

  Linux 3.0-rc5 (2011-06-27 19:12:22 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git pwm

Sascha Hauer (2):
      PWM: add pwm framework support
      pwm: Add a i.MX23/28 pwm driver

 Documentation/pwm.txt |   56 ++++++++++
 MAINTAINERS           |    5 +
 drivers/Kconfig       |    2 +
 drivers/Makefile      |    1 +
 drivers/pwm/Kconfig   |   12 ++
 drivers/pwm/Makefile  |    1 +
 drivers/pwm/core.c    |  246 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pwm/mxs-pwm.c |  275 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h   |   38 +++++++
 9 files changed, 636 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/pwm.txt
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/core.c
 create mode 100644 drivers/pwm/mxs-pwm.c
