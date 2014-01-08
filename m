From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 8 Jan 2014 15:23:09 +0100
Subject: [GIT PULL] at91: cleanup for 3.14 #2
Message-ID: <1389190989-8261-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A little "cleanup" pull-request for 3.14 that goes on top of the previous
AT91 cleanup material.
The thing to note from this pull-request is the beginning of board file removal
thank to the conversion to DT. We are still waiting for more feedback from
board maintainer to intensify the effort.

Thanks, best regards,

The following changes since commit b46e837d8ef1f3c777bbf9513e2cdb5d87d6c374:

  ARM: at91/dt: remove old clk material (2013-12-02 15:31:29 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-cleanup2

for you to fetch changes up to e91a5555df5883bbc204b0e1f8e0489d3f7f3f2e:

  ARM: at91: switch Calao QIL-A9260 board to DT (2013-12-19 17:27:30 +0100)

----------------------------------------------------------------
Second cleanup pull-request for 3.14:
- a tiny fix for the recent AT91 CCF implementation
- the switch of one platform to DT with board file removal

----------------------------------------------------------------
Boris BREZILLON (1):
      clk: at91: fix pmc_clk_ids data type attriubte

Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: switch Calao QIL-A9260 board to DT

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-qil_a9260.dts        | 185 +++++++++++++++++++
 arch/arm/configs/at91sam9260_9g20_defconfig |   1 -
 arch/arm/mach-at91/Kconfig.non_dt           |   6 -
 arch/arm/mach-at91/Makefile                 |   1 -
 arch/arm/mach-at91/board-qil-a9260.c        | 266 ----------------------------
 drivers/clk/at91/pmc.c                      |   2 +-
 7 files changed, 187 insertions(+), 275 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-qil_a9260.dts
 delete mode 100644 arch/arm/mach-at91/board-qil-a9260.c

-- 
Nicolas Ferre
