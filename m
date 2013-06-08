From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 9 Jun 2013 01:23:24 +0400
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7778: fix Ether device name
Message-ID: <201306090123.24709.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While recasting commit 524219146a89aee5366326c225ccd71231419d89 (ARM: shmobile:
R8A7778: add Ether support), I made a typo in the platform device's name: used
underscore instead of hyphen.

However, there's now patch merged to net-next.git renaming the platform device
from "sh-eth" to "r8a777x-ehter", so it makes the most sense to change the name
straight to that one.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is atop of the 'renesas-next-20130607' tag of the 'renesas.git' tree
and the USB patches I have submitted earlier.

Changes in version 2:
- changed the platform device's name as in the patch merged to 'net-next.git';
- lowercased the SoC name in the subject.

 arch/arm/mach-shmobile/setup-r8a7778.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -196,7 +196,7 @@ static struct resource ether_resources[]
 
 void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
 {
-	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
+	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
 					  ether_resources,
 					  ARRAY_SIZE(ether_resources),
 					  pdata, sizeof(*pdata));
