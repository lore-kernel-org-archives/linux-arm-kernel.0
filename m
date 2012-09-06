From: horms@verge.net.au (Simon Horman)
Date: Thu,  6 Sep 2012 11:04:33 +0900
Subject: [PATCH 2/3] ARM: shmobile: marzen: fixup regulator id for smsc911x
In-Reply-To: <1346897074-6276-1-git-send-email-horms@verge.net.au>
References: <1346897074-6276-1-git-send-email-horms@verge.net.au>
Message-ID: <1346897074-6276-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

regulator id = 0 is used for sh_mobile_sdhi.
smsc911x's regulator can use id = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index dec3ffc..cbf9f25 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -120,7 +120,7 @@ static void __init marzen_init(void)
 {
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
-	regulator_register_fixed(0, dummy_supplies,
+	regulator_register_fixed(1, dummy_supplies,
 				ARRAY_SIZE(dummy_supplies));
 
 	r8a7779_pinmux_init();
-- 
1.7.10.4
