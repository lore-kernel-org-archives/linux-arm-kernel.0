From: derkling@gmail.com (Patrick Bellasi)
Date: Mon, 30 Nov 2009 10:48:03 +0100
Subject: [PATCH 0/3] Add support for Daricom C3-Ax03 board
In-Reply-To: <20091129234917.GB18841@game.jcrosoft.org>
References: <20091129234917.GB18841@game.jcrosoft.org>
Message-ID: <1259574486-13391-1-git-send-email-derkling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add suppor to the C3-Ax03 board by Daricom, addressing some
review notes by Jean-Christophe.

A small update to the cpu specific file allows to avoid routing of EXT2 and
ETX3 signals to the same pins used by TWI. This update is reflected into all
boards using a not RMII macb.

The defconfig is on a separate patch for easy of review.

Patrick Bellasi (3):
  AT91: update at91_eth_data for ETX2-3 on PA10-11
  [AT91] Add support for the Daricom C3-Ax03 board
  [AT91] Add defconfig for the Daricom C3-Ax03 board

 arch/arm/configs/c3ax03_defconfig        | 1483 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Kconfig               |    6 +
 arch/arm/mach-at91/Makefile              |    1 +
 arch/arm/mach-at91/at91sam9260_devices.c |    9 +-
 arch/arm/mach-at91/board-afeb-9260v1.c   |    1 +
 arch/arm/mach-at91/board-c3ax03.c        |  364 ++++++++
 arch/arm/mach-at91/board-cam60.c         |    1 +
 arch/arm/mach-at91/board-csb337.c        |    1 +
 arch/arm/mach-at91/board-csb637.c        |    1 +
 arch/arm/mach-at91/board-ecbat91.c       |    1 +
 arch/arm/mach-at91/board-kafa.c          |    1 +
 arch/arm/mach-at91/board-kb9202.c        |    1 +
 arch/arm/mach-at91/board-sam9-l9260.c    |    1 +
 arch/arm/mach-at91/include/mach/board.h  |    1 +
 14 files changed, 1870 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/configs/c3ax03_defconfig
 create mode 100644 arch/arm/mach-at91/board-c3ax03.c
