From: pza@pengutronix.de (Philipp Zabel)
Date: Sat, 30 Mar 2013 12:20:02 +0100
Subject: [GIT PULL] Reset controller API
Message-ID: <20130330112002.GA29752@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

the following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:

  Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git reset/for_v3.10

for you to fetch changes up to 3e6e69e1e3027427530cabfe9b93358eb477e877:

  reset: Add driver for gpio-controlled reset pins (2013-03-30 11:03:10 +0100)

They add a simple API for devices to request being reset by separate
reset controller hardware and implement the reset signal device tree
bindings proposed by Stephen Warren.
The patches have been discussed on the linux-arm-kernel list under the topic
"Reset controller API to reset IP modules on i.MX5 and i.MX6".

----------------------------------------------------------------
Philipp Zabel (2):
      reset: Add reset controller API
      reset: Add driver for gpio-controlled reset pins

Stephen Warren (1):
      dt: describe base reset signal binding

 .../devicetree/bindings/reset/gpio-reset.txt       |  37 +++
 Documentation/devicetree/bindings/reset/reset.txt  |  75 ++++++
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   3 +
 drivers/reset/Kconfig                              |  26 ++
 drivers/reset/Makefile                             |   2 +
 drivers/reset/core.c                               | 297 +++++++++++++++++++++
 drivers/reset/gpio-reset.c                         | 208 +++++++++++++++
 include/linux/reset-controller.h                   |  51 ++++
 include/linux/reset.h                              |  17 ++
 10 files changed, 718 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/reset.txt
 create mode 100644 drivers/reset/Kconfig
 create mode 100644 drivers/reset/Makefile
 create mode 100644 drivers/reset/core.c
 create mode 100644 drivers/reset/gpio-reset.c
 create mode 100644 include/linux/reset-controller.h
 create mode 100644 include/linux/reset.h

regards
Philipp
