From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2012 14:38:59 +0900
Subject: [PATCH] ARM: shmobile: marzen: fixup smsc911x id for regulator
In-Reply-To: <1346305139-24337-1-git-send-email-horms@verge.net.au>
References: <1346305139-24337-1-git-send-email-horms@verge.net.au>
Message-ID: <1346305139-24337-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

dummy_supplies for smsc911x are registered as "smsc911x".
smsc911x driver needs id = -1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 3a528cf..fcf5a47 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -67,7 +67,7 @@ static struct smsc911x_platform_config smsc911x_platdata = {
 
 static struct platform_device eth_device = {
 	.name		= "smsc911x",
-	.id		= 0,
+	.id		= -1,
 	.dev  = {
 		.platform_data = &smsc911x_platdata,
 	},
-- 
1.7.10.2.484.gcd07cc5
