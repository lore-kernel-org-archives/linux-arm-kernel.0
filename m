From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1=20=C4=8Cech?=)
Date: Mon, 31 Aug 2009 19:25:59 +0200
Subject: [PATCH 3/5] Treo680: fix freed GPIO in treo680_irda_shutdown()
In-Reply-To: <1251739561-28972-3-git-send-email-sleep_walker@suse.cz>
References: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
	<1251739561-28972-2-git-send-email-sleep_walker@suse.cz>
	<1251739561-28972-3-git-send-email-sleep_walker@suse.cz>
Message-ID: <1251739561-28972-4-git-send-email-sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tom?? ?ech <sleep walker@suse.cz>


Signed-off-by: Tom?? ?ech <sleep_walker@suse.cz>
---
 arch/arm/mach-pxa/treo680.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/treo680.c b/arch/arm/mach-pxa/treo680.c
index 57bccc3..d88114c 100644
--- a/arch/arm/mach-pxa/treo680.c
+++ b/arch/arm/mach-pxa/treo680.c
@@ -325,7 +325,7 @@ err1:
 
 static void treo680_irda_shutdown(struct device *dev)
 {
-	gpio_free(GPIO_NR_TREO680_AMP_EN);
+	gpio_free(GPIO_NR_TREO680_IR_EN);
 }
 
 static struct pxaficp_platform_data treo680_ficp_info = {
-- 
1.6.3.3
