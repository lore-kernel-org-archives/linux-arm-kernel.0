From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:59:28 +0900
Subject: [PATCH 4/9] ARM: shmobile: r8a7778: fix Ether device name
In-Reply-To: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
References: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369648773-7941-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

While recasting the commit "ARM: shmobile: R8A7778: add Ether support", I made a
typo in the platform device's name: used underscore instead of hyphen.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index d6ee521..45f0e45 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -96,7 +96,7 @@ static struct resource ether_resources[] = {
 
 void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
 {
-	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
+	platform_device_register_resndata(&platform_bus, "sh-eth", -1,
 					  ether_resources,
 					  ARRAY_SIZE(ether_resources),
 					  pdata, sizeof(*pdata));
-- 
1.7.10.4
