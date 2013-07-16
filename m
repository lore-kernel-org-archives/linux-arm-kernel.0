From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Jul 2013 02:18:16 -0700
Subject: [GIT PULL] pinctrl-single SoC specific support for v3.12
Message-ID: <20130716091816.GU7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's a pull request for the pinctrl-single changes posted
few weeks ago. Assuming this pull request and the patches
are OK, I'd like to also merge this branch into omap tree so
we can have the wake-up events working. So we'd have to
establish keeping these commits immutable.

Note that this series does not depend on the dynamic remuxing
patches I just posted. These patches can be used without the
dynamic remuxing support for devices that have dedicated
wake-up path and don't need remuxing, such as UART on most
omaps.

Regards,

Tony


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/pinctrl-single-for-linus

for you to fetch changes up to 8f406c0772ace721f0350c92acd043732285ba9f:

  pinctrl: single: omap: Add SoC specific module for wake-up events (2013-07-15 00:17:07 -0700)

----------------------------------------------------------------
Pinctrl single changes to add support for SoC specific features
that were too late for v3.11. This branch is needed as a dependency
also for the omap tree for off-idle and USB wake-up events, so
posting it as a pull request.

----------------------------------------------------------------
Tony Lindgren (3):
      pinctrl: single: Prepare for supporting SoC specific features
      pinctrl: single: Add hardware specific hooks for IRQ and GPIO wake-up events
      pinctrl: single: omap: Add SoC specific module for wake-up events

 .../devicetree/bindings/pinctrl/pinctrl-single.txt |   5 +
 drivers/pinctrl/Makefile                           |   3 +-
 drivers/pinctrl/pinctrl-single-omap.c              | 287 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-single.c                   | 158 +++++++++---
 drivers/pinctrl/pinctrl-single.h                   |  43 +++
 include/linux/platform_data/pinctrl-single-omap.h  |   4 +
 6 files changed, 468 insertions(+), 32 deletions(-)
 create mode 100644 drivers/pinctrl/pinctrl-single-omap.c
 create mode 100644 drivers/pinctrl/pinctrl-single.h
 create mode 100644 include/linux/platform_data/pinctrl-single-omap.h
