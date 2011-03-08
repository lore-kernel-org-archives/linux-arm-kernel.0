From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 07 Mar 2011 22:44:31 -0700
Subject: [PATCH 3/5] OMAP2+: hwmod: Fix what _init_clock returns
In-Reply-To: <20110308054315.1309.10538.stgit@twilight.localdomain>
References: <20110308054315.1309.10538.stgit@twilight.localdomain>
Message-ID: <20110308054429.1309.36007.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

_init_clock always returns 0 and does
not propogate the error (in case of failure)
back to the caller, causing _init_clocks to
fail silently.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9b4f6cd..671f871 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -926,7 +926,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
 
-	return 0;
+	return ret;
 }
 
 /**
