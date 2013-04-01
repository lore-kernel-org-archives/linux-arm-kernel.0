From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Apr 2013 14:31:27 +0800
Subject: [GIT PULL] reset API for 3.10
Message-ID: <20130401063126.GC1693@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the pull request of including reset API for 3.10.  We want to
have it go via arm-soc tree, since we will have platform patches
depending on it.

Thanks,
Shawn

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/reset-for-3.10

for you to fetch changes up to 749c6f89e9b1579ca7f00c18dec09e3490d394ec:

  reset: Add driver for gpio-controlled reset pins (2013-03-31 23:03:35 +0800)

----------------------------------------------------------------
It adds a simple API for devices to request being reset by separate
reset controller hardware and implements the reset signal device tree
binding proposed by Stephen Warren.  The immediate user for this API
is i.MX System Reset Controller (SRC).  Tegra and a few other platforms
will also use this API.

----------------------------------------------------------------
Philipp Zabel (2):
      reset: Add reset controller API
      reset: Add driver for gpio-controlled reset pins

Stephen Warren (1):
      dt: describe base reset signal binding

 .../devicetree/bindings/reset/gpio-reset.txt       |   37 +++
 Documentation/devicetree/bindings/reset/reset.txt  |   75 +++++
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    3 +
 drivers/reset/Kconfig                              |   26 ++
 drivers/reset/Makefile                             |    2 +
 drivers/reset/core.c                               |  297 ++++++++++++++++++++
 drivers/reset/gpio-reset.c                         |  208 ++++++++++++++
 include/linux/reset-controller.h                   |   51 ++++
 include/linux/reset.h                              |   18 ++
 10 files changed, 719 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/reset.txt
 create mode 100644 drivers/reset/Kconfig
 create mode 100644 drivers/reset/Makefile
 create mode 100644 drivers/reset/core.c
 create mode 100644 drivers/reset/gpio-reset.c
 create mode 100644 include/linux/reset-controller.h
 create mode 100644 include/linux/reset.h
