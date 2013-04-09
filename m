From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 9 Apr 2013 21:47:51 +0400
Subject: [PATCH 1/2] ARM: shmobile: R8A7778: fix Ether device name
Message-ID: <201304092147.51621.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While recasting the commit "ARM: shmobile: R8A7778: add Ether support", I made a
typo in the platform device's name: used underscore instead of hyphen. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is atop of the 'renesas-next-20130410' tag of the 'renesas.git' tree.

 arch/arm/mach-shmobile/setup-r8a7778.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -96,7 +96,7 @@ static struct resource ether_resources[]
 
 void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
 {
-	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
+	platform_device_register_resndata(&platform_bus, "sh-eth", -1,
 					  ether_resources,
 					  ARRAY_SIZE(ether_resources),
 					  pdata, sizeof(*pdata));
