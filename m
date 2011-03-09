From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 9 Mar 2011 13:02:10 +0100
Subject: [PATCH 0/3] TP6105x core and regulator driver v2
Message-ID: <1299672130-4669-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds an MFD device for handling the TPS61052 boost converter
used in audio.

Changes v1->v2:
- Only register the mfd cells that are actually going to be used
  in the core driver (Mark)
- Don't set deafault valies in any registers on startup of core nor
  regulator driver (Mark)
- Use voltage set/get selector APIs to simplify regulator code (Mark)
- Reorder initcall placements (Mark)
- Platform data only allows one voltage so don't mark the consumer
  as "changeable" (Mark)
- Remove mfd cells on exit from tps6105x core (self)
- Clear separation of core driver and regulator patch in the
  series (Jonas)
- Do not mark core driver experimental (Mark)
- De-parenthesize numerals in header file (Jonas)
- kmalloc rather than kzalloc core state holder (Jonas)
- Update copyright headers (Jonas, Lee)

If any of you guys are happy, acked/reviewed-by is appreciated.

Linus Walleij (3):
  mfd: add a core driver for TI TPS61050/TPS61052 chips v2
  regulator: add a subdriver for TI TPS6105x regulator portions v2
  mach-ux500: configure board for the TPS61052 regulator v2

 arch/arm/mach-ux500/Kconfig                   |    1 +
 arch/arm/mach-ux500/board-mop500-regulators.c |   25 +++
 arch/arm/mach-ux500/board-mop500-regulators.h |    1 +
 arch/arm/mach-ux500/board-mop500.c            |   14 ++
 drivers/mfd/Kconfig                           |   11 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/tps6105x.c                        |  245 +++++++++++++++++++++++++
 drivers/regulator/Kconfig                     |    9 +
 drivers/regulator/Makefile                    |    2 +-
 drivers/regulator/tps6105x-regulator.c        |  195 ++++++++++++++++++++
 include/linux/mfd/tps6105x.h                  |  101 ++++++++++
 11 files changed, 604 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mfd/tps6105x.c
 create mode 100644 drivers/regulator/tps6105x-regulator.c
 create mode 100644 include/linux/mfd/tps6105x.h

-- 
1.7.3.2
