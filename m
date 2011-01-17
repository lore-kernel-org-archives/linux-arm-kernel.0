From: balbi@ti.com (Felipe Balbi)
Date: Mon, 17 Jan 2011 06:31:18 +0200
Subject: [PATCH 5/7] arm: omap2: mux: fix compile warning
In-Reply-To: <1295238680-26738-1-git-send-email-balbi@ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
Message-ID: <1295238680-26738-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following compile warning:
arch/arm/mach-omap2/mux.c: In function '_omap_mux_get_by_name':
arch/arm/mach-omap2/mux.c:163:17: warning: 'found_mode' may be used
uninitialized in this function

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/mux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index df8d2f2..fae49d1 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -160,7 +160,7 @@ static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
 	struct omap_mux *mux = NULL;
 	struct omap_mux_entry *e;
 	const char *mode_name;
-	int found = 0, found_mode, mode0_len = 0;
+	int found = 0, found_mode = 0, mode0_len = 0;
 	struct list_head *muxmodes = &partition->muxmodes;
 
 	mode_name = strchr(muxname, '.');
-- 
1.7.3.4.598.g85356
