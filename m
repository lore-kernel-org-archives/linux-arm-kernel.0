From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 21 Jul 2011 14:57:35 +0200
Subject: [PATCH 2/4 v2] ARM: s3c64xx: Save/restore S3C64XX_SDMA_SEL on
 suspend/resume.
Message-ID: <mailman.94.1313970567.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes sure that S3C64XX_SDMA_SEL register is preserved during
sleep mode, as it is critical for DMA operation and the DMA driver alone
does not provide any power management facilities.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/pm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index bc1c470..b9c0536 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -84,6 +84,8 @@ static struct sleep_save misc_save[] = {
 	SAVE_ITEM(S3C64XX_MEM0CONSLP0),
 	SAVE_ITEM(S3C64XX_MEM0CONSLP1),
 	SAVE_ITEM(S3C64XX_MEM1CONSLP),
+
+	SAVE_ITEM(S3C64XX_SDMA_SEL),
 };
 
 void s3c_pm_configure_extint(void)
-- 
1.7.6
