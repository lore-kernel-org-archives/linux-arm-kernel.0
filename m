From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 16 Feb 2011 17:41:24 +0530
Subject: [PATCH 2/3] OMAP2+: hwmod: Fix what _init_clock returns
In-Reply-To: <1297858285-7056-2-git-send-email-rnayak@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
	<1297858285-7056-2-git-send-email-rnayak@ti.com>
Message-ID: <1297858285-7056-3-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_init_clock always returns 0 and does
not propogate the error (in case of failure)
back to the caller, causing _init_clocks to
fail silently.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cd9dcde..960461f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -926,7 +926,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
1.7.0.4
