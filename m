From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Feb 2012 21:32:12 -0600
Subject: [PATCH 2/4] ARM: sa1100: fix simpad compile error
In-Reply-To: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329449534-23811-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

simpad_ucb1x00_data reference has an extra '&', so remove it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-sa1100/simpad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 0a08d71..4c6ec9a 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -189,7 +189,7 @@ static struct ucb1x00_plat_data simpad_ucb1x00_data = {
 static struct mcp_plat_data simpad_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
-	.codec_pdata	= &&simpad_ucb1x00_data,
+	.codec_pdata	= &simpad_ucb1x00_data,
 };
 
 
-- 
1.7.5.4
