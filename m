From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 1 Jul 2011 11:44:03 +0200
Subject: [RFC PATCH 0/3] base board consolidation
Message-ID: <20110701094403.GT11559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

for a customer who uses a SoC-module already supported in mainline but a
custom base board I'm currently coding the umpteenth baseboard
abstraction. So I tried to come up with a generic definition.

I converted only one machine (mx31moboard) for now, possible other users
I found are:

	mx31lilly
	mx31lite
	colibri-pxa270

but I wouldn't be surprised if there are more.

Patch 2 keeps the existing kernel parameter for mx31moboard. That can be
removed later as is done in patch 3. The latter shouldn't be applied now
and is only included to improve the diffstat :-)

At some time this will probably be obsoleted by device tree stuff, the
upside of this approach is that it already works today without the need
to adapt the bootloader.

Best regards
Uwe

The following changes since commit ca56a95eedcc95f8fea7b49c87565cd961d74fe2:

  Merge branch 'drm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6 (2011-06-29 18:18:48 -0700)

are available in the git repository at:

  git.ptx:/git/ukl/linux-2.6.git baseboardconsolidation

Uwe Kleine-K?nig (3):
      ARM: common abstraction for specifying a baseboard
      ARM: imx/mx31moboard: convert to new baseboard handling
      ARM: imx/mx31moboard: remove obsolete baseboard handling

 Documentation/kernel-parameters.txt                |    2 +
 arch/arm/common/Kconfig                            |    3 +
 arch/arm/common/Makefile                           |    1 +
 arch/arm/common/baseboard.c                        |   58 ++++++++++++++++++++
 arch/arm/include/asm/baseboard.h                   |   31 +++++++++++
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c               |   38 +++++++-------
 arch/arm/mach-imx/mx31moboard-devboard.c           |    5 +-
 arch/arm/mach-imx/mx31moboard-marxbot.c            |    5 +-
 arch/arm/mach-imx/mx31moboard-smartbot.c           |   18 ++----
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |   16 ++----
 11 files changed, 133 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/common/baseboard.c
 create mode 100644 arch/arm/include/asm/baseboard.h
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
