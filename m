From: lukma@denx.de (Lukasz Majewski)
Date: Fri, 17 Nov 2017 00:22:35 +0100
Subject: [PATCH 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
Message-ID: <20171116232239.16823-1-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for Liebherr's BK3 board, being
a derivative of TS72XX design.

This patchset consists of following patches:

- ts72xx.[c|h] cosmetic cleanup/improvement
- Move the common code for ts72xx and BK3 to ts72xx-common.c - this
  code can be reused by other designs build around ts72xx
- The Liebherr's BK3 board has been added with re-using code of
  ts72xx.c

Lukasz Majewski (4):
  ARM: ep93xx: ts72xx: Use DEFINE_RES_MEM macros where applicable
  ARM: ep93xx: ts72xx: Provide include guards for ts72xx.h file
  ARM: ep93xx: ts72xx: Exclude reusable part of the ts72xx board
  ARM: ep93xx: ts72xx: Add support for BK3 board - ts72xx derivative

 arch/arm/mach-ep93xx/Kconfig         |  11 +++
 arch/arm/mach-ep93xx/Makefile        |   2 +
 arch/arm/mach-ep93xx/bk3.c           |  88 +++++++++++++++++++
 arch/arm/mach-ep93xx/ts72xx-common.c | 158 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-ep93xx/ts72xx.c        | 136 ++----------------------------
 arch/arm/mach-ep93xx/ts72xx.h        |  14 ++++
 arch/arm/tools/mach-types            |   1 +
 7 files changed, 279 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/bk3.c
 create mode 100644 arch/arm/mach-ep93xx/ts72xx-common.c

-- 
2.11.0
