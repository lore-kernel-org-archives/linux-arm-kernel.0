From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 17:54:42 +0200
Subject: [PATCH 03/33] Removing dead OMAP_MUX_ERRORS
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <b6ca168f9459162f2c96aa8ef999047a3c4f6f9c.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP_MUX_ERRORS doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-omap1/mux.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 8434137..1ddb02c 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -439,12 +439,7 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 			       cfg->pull_name, cfg->pull_reg, pull_orig, pull);
 	}
 #endif
-
-#ifdef CONFIG_OMAP_MUX_ERRORS
-	return warn ? -ETXTBSY : 0;
-#else
 	return 0;
-#endif
 }
 
 int __init omap1_mux_init(void)
-- 
1.7.0.4
