From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 28 Oct 2009 17:35:43 +0100
Subject: [PATCH] Make it possible for U300 LDO D to shut down
Message-ID: <1256747743-18811-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the regulator platform config for U300 so that the
LDO D regulator can change status and shut down the system and
the pm_shutdown() hook in regulator.c starts working.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/i2c.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-u300/i2c.c b/arch/arm/mach-u300/i2c.c
index 7bc2503..c73ed06 100644
--- a/arch/arm/mach-u300/i2c.c
+++ b/arch/arm/mach-u300/i2c.c
@@ -130,6 +130,7 @@ static struct ab3100_platform_data ab3100_plf_data = {
 				.min_uV = LDO_D_VOLTAGE,
 				.max_uV = LDO_D_VOLTAGE,
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
+				.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 				/*
 				 * Actually this is boot_on but we need
 				 * to reference count it externally to
-- 
1.6.3.3
