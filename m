From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Apr 2016 11:28:39 +1000
Subject: [PATCH 04/11] soc: renesas: rcar-sysc: Make rcar_sysc_power_is_off()
 static
In-Reply-To: <cover.1461632180.git.horms+renesas@verge.net.au>
References: <cover.1461632180.git.horms+renesas@verge.net.au>
Message-ID: <2f024cef5b064d5498fe466dfe9492d46b5b12a4.1461632180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commit b12ff41658171f53 ("ARM: shmobile: r8a7779: Remove legacy PM
Domain remainings"), rcar_sysc_power_is_off() is no longer used from
SoC-specific code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c       | 2 +-
 include/linux/soc/renesas/rcar-sysc.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 95f2b59cbd76..4e760d63f2ab 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -152,7 +152,7 @@ int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
 	return rcar_sysc_power(sysc_ch, true);
 }
 
-bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
+static bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	unsigned int st;
 
diff --git a/include/linux/soc/renesas/rcar-sysc.h b/include/linux/soc/renesas/rcar-sysc.h
index 96f30c288388..92fc613ab23d 100644
--- a/include/linux/soc/renesas/rcar-sysc.h
+++ b/include/linux/soc/renesas/rcar-sysc.h
@@ -11,7 +11,6 @@ struct rcar_sysc_ch {
 
 int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
 int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
-bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch);
 void __iomem *rcar_sysc_init(phys_addr_t base);
 
 #endif /* __LINUX_SOC_RENESAS_RCAR_SYSC_H__ */
-- 
2.7.0.rc3.207.g0ac5344
