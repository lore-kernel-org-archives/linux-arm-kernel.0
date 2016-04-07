From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  7 Apr 2016 14:20:21 +0200
Subject: [PATCH v4 04/11] soc: renesas: rcar-sysc: Make
 rcar_sysc_power_is_off() static
In-Reply-To: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1460031628-13336-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit b12ff41658171f53 ("ARM: shmobile: r8a7779: Remove legacy PM
Domain remainings"), rcar_sysc_power_is_off() is no longer used from
SoC-specific code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v4:
  - Add Reviewed-by,

v3:
  - New.
---
 drivers/soc/renesas/rcar-sysc.c       | 2 +-
 include/linux/soc/renesas/rcar-sysc.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 3cb19b599cee4ee5..bdab8ac6803300e7 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -154,7 +154,7 @@ int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
 	return rcar_sysc_power(sysc_ch, true);
 }
 
-bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
+static bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	unsigned int st;
 
diff --git a/include/linux/soc/renesas/rcar-sysc.h b/include/linux/soc/renesas/rcar-sysc.h
index 96f30c2883881d97..92fc613ab23db091 100644
--- a/include/linux/soc/renesas/rcar-sysc.h
+++ b/include/linux/soc/renesas/rcar-sysc.h
@@ -11,7 +11,6 @@ struct rcar_sysc_ch {
 
 int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
 int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
-bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch);
 void __iomem *rcar_sysc_init(phys_addr_t base);
 
 #endif /* __LINUX_SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1
