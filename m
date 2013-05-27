From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:59:25 +0900
Subject: [PATCH 1/9] ARM: shmobile: use do{ }while() on SH_CLK_SET_RATIO()
In-Reply-To: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
References: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369648773-7941-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SH_CLK_SET_RATIO() will be trouble without this patch

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/clock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/clock.h b/arch/arm/mach-shmobile/include/mach/clock.h
index 76ac612..ce29720 100644
--- a/arch/arm/mach-shmobile/include/mach/clock.h
+++ b/arch/arm/mach-shmobile/include/mach/clock.h
@@ -31,9 +31,9 @@ static SH_FIXED_RATIO_CLKg(name, p, r);
 	SH_FIXED_RATIO_CLK(name, p, name);
 
 #define SH_CLK_SET_RATIO(p, m, d)	\
-{			\
+do {			\
 	(p)->mul = m;	\
 	(p)->div = d;	\
-}
+} while (0)
 
 #endif
-- 
1.7.10.4
