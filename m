From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 17 Oct 2013 06:51:46 +0900
Subject: [PATCH] ARM: shmobile: Add r8a7790_register_pfc() function
Message-ID: <20131016215146.4038.57618.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Break out the r8a7790 PFC platform device creation code
to increase readability and follow same style as r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-20131016

 arch/arm/mach-shmobile/setup-r8a7790.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-10-04 19:01:46.000000000 +0900
@@ -34,6 +34,10 @@ static const struct resource pfc_resourc
 	DEFINE_RES_MEM(0xe6060000, 0x250),
 };
 
+#define r8a7790_register_pfc()						\
+	platform_device_register_simple("pfc-r8a7790", -1, pfc_resources, \
+					ARRAY_SIZE(pfc_resources))
+
 #define R8A7790_GPIO(idx)						\
 static const struct resource r8a7790_gpio##idx##_resources[] __initconst = { \
 	DEFINE_RES_MEM(0xe6050000 + 0x1000 * (idx), 0x50),		\
@@ -65,8 +69,7 @@ R8A7790_GPIO(5);
 
 void __init r8a7790_pinmux_init(void)
 {
-	platform_device_register_simple("pfc-r8a7790", -1, pfc_resources,
-					ARRAY_SIZE(pfc_resources));
+	r8a7790_register_pfc();
 	r8a7790_register_gpio(0);
 	r8a7790_register_gpio(1);
 	r8a7790_register_gpio(2);
