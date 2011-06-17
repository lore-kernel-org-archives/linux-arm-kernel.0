From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 17 Jun 2011 18:11:32 +0400
Subject: [PATCH] collie: don't read GPSR
Message-ID: <1308319892-13057-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On StrongARM GPSR is write-only according to docs, so don't read from
it. Just set the required GPIO.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/collie.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index f28025e..3f32ba2 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -339,7 +339,7 @@ static void __init collie_init(void)
 
 	PCFR = PCFR_OPDE;
 
-	GPSR |= _COLLIE_GPIO_UCB1x00_RESET;
+	GPSR = _COLLIE_GPIO_UCB1x00_RESET;
 
 
 	platform_scoop_config = &collie_pcmcia_config;
-- 
1.7.5.3
