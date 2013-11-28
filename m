From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:40 +0900
Subject: [PATCH 10/16] ARM: shmobile: Add r8a7790_register_pfc() function
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
Message-ID: <8d0b3bf79bfa1dc7d3e2a9dc2b6f2ceea353687f.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Break out the r8a7790 PFC platform device creation code
to increase readability and follow same style as r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index c47bceb..3543c3b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -34,6 +34,10 @@ static const struct resource pfc_resources[] __initconst = {
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
-- 
1.8.4
