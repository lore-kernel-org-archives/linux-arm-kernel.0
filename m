From: r.sricharan@ti.com (R Sricharan)
Date: Thu, 3 May 2012 12:56:14 +0530
Subject: [PATCH 05/13] TEMP: ARM: OMAP5: Update the base address of the
 32k-counter.
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1336029982-31898-6-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not for merge.

Just update the base address of the counter for
OMAP5 soc.

This patch will no longer be needed after rebasing on top of below
series from Vaibhav Hiremath <hvaibhav@ti.com>.

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg67166.html

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/plat-omap/counter_32k.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5068fe5..5a48ec9 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -90,6 +90,8 @@ int __init omap_init_clocksource_32k(void)
 			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
 		else if (cpu_is_omap44xx())
 			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
+		else if (cpu_is_omap54xx())
+			pbase = OMAP54XX_32KSYNCT_BASE + 0x30;
 		else
 			return -ENODEV;
 
-- 
1.7.1
