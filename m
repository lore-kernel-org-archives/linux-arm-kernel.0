From: h-kanigeri2@ti.com (Hari Kanigeri)
Date: Wed, 10 Nov 2010 12:00:18 -0600
Subject: [PATCH v2 6/6] OMAP4: clocks: add dummy clock for mailbox
In-Reply-To: <1289412018-18860-1-git-send-email-h-kanigeri2@ti.com>
References: <1289412018-18860-1-git-send-email-h-kanigeri2@ti.com>
Message-ID: <1289412018-18860-7-git-send-email-h-kanigeri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In omap4, there is no explicit configuration register to enable mailbox clocks.
Defining dummy clock for mailbox clock module to keep the mailbox driver
backward compatible with previous omaps.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e10db7a..bdd9b85 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2687,6 +2687,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"mailboxes_ick",	&dummy_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.7.0
