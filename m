From: mturquette@ti.com (Mike Turquette)
Date: Tue, 13 Dec 2011 20:11:58 -0800
Subject: [PATCH 7/7] HACK: comment WARN_ON in _clkdm_clk_hwmod_disable
In-Reply-To: <1323835918-2371-1-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Message-ID: <1323835918-2371-8-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not-signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index ad07689..825248b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -941,7 +941,7 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 		return -EINVAL;
 
 	if (atomic_read(&clkdm->usecount) == 0) {
-		WARN_ON(1); /* underflow */
+		//WARN_ON(1); /* underflow */
 		return -ERANGE;
 	}
 
-- 
1.7.5.4
