From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Jun 2011 11:03:33 +0200
Subject: [PATCH v2] implement a generic PWM framework
Message-ID: <1309338215-10702-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the comments to the last version, hopefully I addressed
them all. Here is another round of the patches.

changes since last version:

- only kfree() in case of errors
- add missing kfree() in pwmchip_remove()
- drop dynamic pwm id support
- fix typos, remove unused variables
- instantiate pwm_base_common in mxs-pwm driver from resources

The following changes since commit b0af8dfdd67699e25083478c63eedef2e72ebd85:

  Linux 3.0-rc5 (2011-06-27 19:12:22 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git pwm

Sascha Hauer (2):
      PWM: add pwm framework support
      pwm: Add a i.MX23/28 pwm driver

 Documentation/pwm.txt |   56 +++++++++
 MAINTAINERS           |    5 +
 drivers/Kconfig       |    2 +
 drivers/Makefile      |    1 +
 drivers/pwm/Kconfig   |   16 +++
 drivers/pwm/Makefile  |    2 +
 drivers/pwm/core.c    |  220 +++++++++++++++++++++++++++++++++
 drivers/pwm/mxs-pwm.c |  321 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h   |   37 ++++++
 9 files changed, 660 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/pwm.txt
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/core.c
 create mode 100644 drivers/pwm/mxs-pwm.c
