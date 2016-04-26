From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Apr 2016 11:28:37 +1000
Subject: [PATCH 02/11] soc: renesas: rcar-sysc: Improve rcar_sysc_power()
 debug info
In-Reply-To: <cover.1461632180.git.horms+renesas@verge.net.au>
References: <cover.1461632180.git.horms+renesas@verge.net.au>
Message-ID: <68667cebfc0d27d2153d7a6b489f3231b533d9bc.1461632180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Print requested power domain state.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index d59bcdf78f0b..9ba5fd15c53b 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -128,7 +128,7 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
  out:
 	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
 
-	pr_debug("sysc power domain %d: %08x -> %d\n",
+	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
 		 sysc_ch->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
 	return ret;
 }
-- 
2.7.0.rc3.207.g0ac5344
