From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 16:51:34 +0900
Subject: [PATCH 04/27] ARM: shmobile: remove ";
 " from SH_FIXED_RATIO_CLK*() macro
In-Reply-To: <1370591517-20239-1-git-send-email-horms+renesas@verge.net.au>
References: <1370591517-20239-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370591517-20239-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/clock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/clock.h b/arch/arm/mach-shmobile/include/mach/clock.h
index 76ac612..8902044 100644
--- a/arch/arm/mach-shmobile/include/mach/clock.h
+++ b/arch/arm/mach-shmobile/include/mach/clock.h
@@ -24,11 +24,11 @@ struct clk name = {			\
 }
 
 #define SH_FIXED_RATIO_CLK(name, p, r)		\
-static SH_FIXED_RATIO_CLKg(name, p, r);
+static SH_FIXED_RATIO_CLKg(name, p, r)
 
 #define SH_FIXED_RATIO_CLK_SET(name, p, m, d)	\
 	SH_CLK_RATIO(name, m, d);		\
-	SH_FIXED_RATIO_CLK(name, p, name);
+	SH_FIXED_RATIO_CLK(name, p, name)
 
 #define SH_CLK_SET_RATIO(p, m, d)	\
 {			\
-- 
1.8.2.1
