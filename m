From: bengt.g.jonsson@stericsson.com (Bengt Jonsson)
Date: Tue, 23 Nov 2010 19:25:51 +0100
Subject: [PATCH 0/3] regulators: Update of ab8500 driver
Message-ID: <1290536754-21775-1-git-send-email-bengt.g.jonsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the ab8500 regulator driver, changes how the regulator
board configuration is handled by the ab8500 mfd core and finally makes the 
the regulator board configuration available to the regulator driver.

Note that the second and third patches depend on the first patch.

 arch/arm/mach-ux500/board-mop500-regulators.c |  153 ++++-----
 arch/arm/mach-ux500/board-mop500-regulators.h |   18 +
 arch/arm/mach-ux500/board-mop500.c            |    4 +
 drivers/regulator/ab8500.c                    |  448 +++++++++++++++++--------
 include/linux/mfd/ab8500.h                    |    1 +
 include/linux/regulator/ab8500.h              |   27 +-
 6 files changed, 428 insertions(+), 223 deletions(-)
