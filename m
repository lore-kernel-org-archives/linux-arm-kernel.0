From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Mar 2012 10:04:34 +0100
Subject: [PATCH] move pwm drivers to new framework
Message-ID: <1331802277-12477-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on Thierrys pwm-v4 patches. It moves the existing
i.MX, samsung and vt8500 drivers over to the new framework. This is only
compile tested, no runtime tests at all. I can test the i.MX driver myself,
but it would be good to have some testers for samsung and vt8500.

Sascha

The following changes since commit 07e34a1f9a21c9f72e86a4e1ec64cc2150c89389:

  pwm: temporary fixup (2012-03-15 09:44:52 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git pwm-v4

for you to fetch changes up to dc7c38dab4355ff3a43e5b9356d180e72a923ed3:

  ARM vt8500: Move vt8500 pwm driver to pwm framework (2012-03-15 09:45:49 +0100)

----------------------------------------------------------------
Sascha Hauer (3):
      ARM i.MX: Move i.MX pwm driver to pwm framework
      ARM Samsung: Move s3c pwm driver to pwm framework
      ARM vt8500: Move vt8500 pwm driver to pwm framework

 arch/arm/mach-vt8500/Makefile                      |    2 -
 arch/arm/plat-mxc/Kconfig                          |    6 -
 arch/arm/plat-mxc/Makefile                         |    1 -
 arch/arm/plat-samsung/Makefile                     |    4 -
 drivers/pwm/Kconfig                                |   27 +++
 drivers/pwm/Makefile                               |    5 +
 arch/arm/plat-mxc/pwm.c => drivers/pwm/pwm-imx.c   |  155 ++++++---------
 .../pwm.c => drivers/pwm/pwm-samsung.c             |  215 ++++++++------------
 .../mach-vt8500/pwm.c => drivers/pwm/pwm-vt8500.c  |  124 ++++--------
 9 files changed, 216 insertions(+), 323 deletions(-)
 rename arch/arm/plat-mxc/pwm.c => drivers/pwm/pwm-imx.c (66%)
 rename arch/arm/plat-samsung/pwm.c => drivers/pwm/pwm-samsung.c (61%)
 rename arch/arm/mach-vt8500/pwm.c => drivers/pwm/pwm-vt8500.c (64%)
