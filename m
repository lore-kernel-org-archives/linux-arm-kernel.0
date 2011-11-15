From: balbi@ti.com (Felipe Balbi)
Date: Tue, 15 Nov 2011 10:46:05 +0200
Subject: [PATCH/RESEND #3 7/7] arm: omap: smartreflex: micro-optimization for
 sanity check
In-Reply-To: <1321346765-16633-1-git-send-email-balbi@ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
Message-ID: <1321346765-16633-8-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

val && (val != 1) == val > 1

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index a5399df..9fee277 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -868,7 +868,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	}
 
 	/* Sanity check */
-	if (val && (val != 1)) {
+	if (val > 1) {
 		pr_warning("%s: Invalid argument %lld\n", __func__, val);
 		return -EINVAL;
 	}
-- 
1.7.8.rc0
