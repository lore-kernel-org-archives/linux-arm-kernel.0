From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 00:51:28 +0200
Subject: [patch-v2.6.33-rc2+ 08/12] arm: omap: io: kill compile warning
In-Reply-To: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Message-ID: <1262127092-14878-9-git-send-email-felipe.balbi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when building omap4 defconfigs, io.c will warn about unused
_omap2_init_reprogram_sdrc, that's because that functio is
only used ifndef CONFIG_ARCH_OMAP4, so add the missing
ifndef CONFIG_ARCH_OMAP4 to _omap2_init_reprogram_sdrc
definition.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/io.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5a79964..9e868fa 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -276,6 +276,7 @@ void __init omap2_map_common_io(void)
  * -EINVAL if the dpll3_m2_ck cannot be found, 0 if called on OMAP2,
  * or passes along the return value of clk_set_rate().
  */
+#ifndef CONFIG_ARCH_OMAP4
 static int __init _omap2_init_reprogram_sdrc(void)
 {
 	struct clk *dpll3_m2_ck;
@@ -299,6 +300,7 @@ static int __init _omap2_init_reprogram_sdrc(void)
 
 	return v;
 }
+#endif
 
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1)
-- 
1.6.6.35.g1d85d
