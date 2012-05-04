From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 4 May 2012 16:57:19 +0300
Subject: [PATCH 0/3] ARM: OMAP4: add support for TPS62361 PMIC
Message-ID: <1336139842-845-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set adds support for TPS62361 PMIC, which is used to power
MPU voltagedomain on OMAP4460 boards. These patches apply on top
of 3.4 + my voltagedomain fixes set to avoid adding redundant code.
Working tree available here for interested parties:

git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.4-voltdm-tps-v1

Tree has been tested with:
- omap3beagle board
- omap4panda es board (OMAP4460)
- omap4blaze board (OMAP4430)

Tested modifying the voltage levels on all core regulators (vdd1...vdd3)
and measuring that the voltages do actually change.

Patch #1 was needed before the voltages could be modified on a panda
board es device, otherwise the timing for the I2C channel was so bogus
it usually failed. The values used were taken from an android tree and
are based on TI analysis.

-Tero
