From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 11:44:36 +0900
Subject: [PATCH 00/16 v1.1] SCIF, I2C and FSI pinctrl functions for sh73a0
Message-ID: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series is a follow-up to "[PATCH 00/16] SCIF, I2C and FSI pinctrl
functions for sh73a0" by Laurent Pinchart. I am primarily posting it for
his review.

This series differs from the series posted by Laurent in the following ways:

* Due to some slightly over-zelous git use on my part the series
  is actually based on a checkout of
  git://linuxtv.org/pinchartl/fbdev.git pinmux-pfc-funcs

  As such it includes several patches not included in the series posted in
  via eimal as the series "[PATCH 00/16] SCIF, I2C and FSI pinctrl
  functions for sh73a0". In particular it includes r8a7740 and r8a7779
  patches.

* I have added the following two patches to update the KZM9G rerence code.

  ARM: shmobile: kzm9g: reference: Register pinctrl mappings for I2C
  ARM: shmobile: kzm9g: reference: Register pinctrl mappings for SCIF

As implied by the second point above, this series is based on
a branch that includes the kzm9g reference code. That branch is

	git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/pinmux-base

Git and diffstat information is provided below to aid review.

Laurent, if you want to change this series in any way just let me know.
I can drop patches indidually or drop the entire series and add a fresh
one from you to the topic branch.

----------------------------------------------------------------
The following changes since commit e90f8429f06947f36693fbdc083fdab15c4164b9:

  ARM: shmobile: armadillo800eva: Register pinctrl mappings for LCDC0 (2013-02-13 09:15:37 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/pinmux-pfc-funcs

for you to fetch changes up to da8ef3c2e6aee4da048e37c4e7a52439e6928379:

  ARM: shmobile: r8a7779: Remove DU function GPIOs (2013-02-13 10:06:59 +0900)

----------------------------------------------------------------
Laurent Pinchart (19):
      ARM: shmobile: bonito: Register pinctrl mappings for LCDC0
      ARM: shmobile: kota2: Register pinctrl mappings for SCIF
      ARM: shmobile: kzm9g: Register pinctrl mappings for LCD
      ARM: shmobile: kzm9g: Register pinctrl mappings for SCIF
      ARM: shmobile: kzm9g: Register pinctrl mappings for I2C
      ARM: shmobile: kzm9g: Register pinctrl mappings for FSI
      sh-pfc: sh73a0: Remove LCD and LCD2 function GPIOS
      sh-pfc: sh73a0: Remove SCIFA and SCIFB function GPIOS
      sh-pfc: sh73a0: Remove I2C function GPIOS
      sh-pfc: sh73a0: Remove FSI function GPIOS
      sh-pfc: r8a7740: Remove LCD0 and LCD1 function GPIOS
      sh-pfc: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
      ARM: shmobile: sh73a0: Remove LCDC and LCDC2 function GPIOs
      ARM: shmobile: sh73a0: Remove SCIFA and SCIFB function GPIOs
      ARM: shmobile: sh73a0: Remove I2C function GPIOs
      ARM: shmobile: sh73a0: Remove FSI function GPIOs
      ARM: shmobile: r8a7740: Remove LCD0 and LCD1 function GPIOs
      ARM: shmobile: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
      ARM: shmobile: r8a7779: Remove DU function GPIOs

Simon Horman (2):
      ARM: shmobile: kzm9g: reference: Register pinctrl mappings for I2C
      ARM: shmobile: kzm9g: reference: Register pinctrl mappings for SCIF

 arch/arm/mach-shmobile/board-bonito.c          |   43 ++---
 arch/arm/mach-shmobile/board-kota2.c           |   42 +++--
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   22 ++-
 arch/arm/mach-shmobile/board-kzm9g.c           |   68 +++----
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |   39 ----
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |   90 ++++-----
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |  237 ++++++++++--------------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |   37 ----
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c           |    9 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            |  182 ------------------
 10 files changed, 217 insertions(+), 552 deletions(-)
