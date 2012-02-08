From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed,  8 Feb 2012 18:43:57 +0100
Subject: [PATCH 12/14] ARM: OMAP3+: SmartReflex: micro-optimization for sanity
 check
In-Reply-To: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Message-ID: <1328723039-15952-13-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

val && (val != 1) == val > 1

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f1db4c6..daf8053 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -886,7 +886,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	}
 
 	/* Sanity check */
-	if (val && (val != 1)) {
+	if (val > 1) {
 		pr_warning("%s: Invalid argument %lld\n", __func__, val);
 		return -EINVAL;
 	}
-- 
1.7.5.4
