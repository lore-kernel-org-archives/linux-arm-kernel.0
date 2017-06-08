From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 08 Jun 2017 10:31:21 +0200
Subject: [GIT PULL] Reset controller changes for v4.13, part 2
Message-ID: <1496910681.2941.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

please consider merging this tag for v4.13. It adds a new TI SCI reset
controller driver, adds reset offsets for Stratix10, and switches to
kref for reference counting on the reset_control structures.

regards
Philipp

The following changes since commit 2acb037fc42b8ce5ae59a7d5db3c9b35672e3dd7:

  reset: Add a Gemini reset controller (2017-05-24 10:46:13 +0200)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.13-2

for you to fetch changes up to 28df169b9afa121153ef2a3ef4ceae72512cde6d:

  reset: Add the TI SCI reset driver (2017-06-06 09:44:17 +0200)

----------------------------------------------------------------
Reset controller changes for v4.13, part 2

- Add reset manager offsets for Stratix10
- Use kref for reset contol reference counting
- Add new TI SCI reset driver for TI Keystone SoCs

----------------------------------------------------------------
Andrew F. Davis (2):
      dt-bindings: reset: Add TI SCI reset binding
      reset: Add the TI SCI reset driver

Philipp Zabel (1):
      reset: use kref for reference counting

Richard Gong (1):
      dt-bindings: reset: Add reset manager offsets for Stratix10

 .../devicetree/bindings/reset/ti,sci-reset.txt     |  62 +++++
 MAINTAINERS                                        |   2 +
 drivers/reset/Kconfig                              |   8 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  23 +-
 drivers/reset/reset-ti-sci.c                       | 269 +++++++++++++++++++++
 include/dt-bindings/reset/altr,rst-mgr-s10.h       | 108 +++++++++
 7 files changed, 465 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 create mode 100644 drivers/reset/reset-ti-sci.c
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-s10.h
