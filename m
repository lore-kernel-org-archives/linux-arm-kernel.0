From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:51 +0900
Subject: [PATCH 01/11] ARM: shmobile: r8a7779: fix Ether device name
In-Reply-To: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106861-25626-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

While recasting commit dace48d04dee46a3409d5e13cd98031522e46377 (ARM: shmobile:
R8A7779: add Ether support), I made a typo in the platform device's name: used
underscore instead of hyphen.

However, there's now patch merged to net-next.git renaming the platform device
from "sh-eth" to "r8a777x-ehter", so it makes the most sense to change the name
straight to that one.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index b0b3948..d8a70dc 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -443,7 +443,7 @@ void __init r8a7779_add_standard_devices(void)
 
 void __init r8a7779_add_ether_device(struct sh_eth_plat_data *pdata)
 {
-	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
+	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
 					  ether_resources,
 					  ARRAY_SIZE(ether_resources),
 					  pdata, sizeof(*pdata));
-- 
1.8.2.1
