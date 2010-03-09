From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue,  9 Mar 2010 11:43:50 +0200
Subject: [PATCH 3/5] [ARM] pxa/cm-x300: fix da903x IRQ line assignment
In-Reply-To: <1268127832-20563-2-git-send-email-grinberg@compulab.co.il>
References: <1268127832-20563-1-git-send-email-grinberg@compulab.co.il>
	<1268127832-20563-2-git-send-email-grinberg@compulab.co.il>
Message-ID: <1268127832-20563-3-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 13fdfd8..6fba9a0 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -650,7 +650,7 @@ static struct da903x_platform_data cm_x300_da9030_info = {
 
 static struct i2c_board_info cm_x300_pmic_info = {
 	I2C_BOARD_INFO("da9030", 0x49),
-	.irq = IRQ_GPIO(0),
+	.irq = IRQ_WAKEUP0,
 	.platform_data = &cm_x300_da9030_info,
 };
 
-- 
1.6.4.4
