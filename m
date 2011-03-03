From: andy@warmcat.com (Andy Green)
Date: Thu, 03 Mar 2011 13:50:14 +0000
Subject: [PATCH 0/4] OMAP 3 and 4 i2c fixes
Message-ID: <20110303134744.30648.91218.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series fixes two issues with OMAP 3 and 4 i2c support.

First, hwmod tables don't have the i2c units marked up as being
for 16-bit access only, which is mandatory.

Second, the i2c peripheral unit init code is confused about using
cpu_is...() and probed peripheral unit version, leading to OMAP3
i2c code doing the wrong thing and accessing nonexistant registers.

---

Andy Green (4):
      OMAP3 and 4 I2C use cpu type consistently for new register availability
      OMAP3 and 4 i2c  mark extended reg enums as extended only
      OMAP3 I2C document why cpu type and not peripheral unit ID used to probe
      OMAP3 and 4 hwmod I2C units only allow 16 bit access


 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 +++---
 drivers/i2c/busses/i2c-omap.c              |   36 +++++++++++++++++++---------
 3 files changed, 31 insertions(+), 16 deletions(-)

-- 
Signature
