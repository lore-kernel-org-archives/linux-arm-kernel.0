From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 1 Jul 2011 22:54:06 +0200
Subject: [PATCH v2 7/8] OMAP: hwmod: Add warnings if enable failed
In-Reply-To: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
References: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Message-ID: <1309553647-14624-8-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the debug into warning to check what IPs are failing.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index df91bb1..64e9830 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -944,6 +944,8 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
+	else
+		pr_warning("omap_hwmod: %s: cannot _init_clocks\n", oh->name);
 
 	return ret;
 }
-- 
1.7.0.4
