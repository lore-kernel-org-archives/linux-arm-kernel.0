From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:52 +0900
Subject: [PATCH 2/4] ARM: shmobile: r8a73a4: Rename cmt registration helper
In-Reply-To: <cover.1414557047.git.horms+renesas@verge.net.au>
References: <cover.1414557047.git.horms+renesas@verge.net.au>
Message-ID: <95e39682033b9940e17108098f08745b8938ab2c.1414557047.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename r8a7790_register_cmt() as r8a73a4_register_cmt() to
reflect name of the SoC in use. The use of r8a7790 appears
to be due to historical sharing of code from that SoC.
Shared code is no longer used.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a73a4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 53f40b7..7a7df71 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -180,7 +180,7 @@ static struct resource cmt1_resources[] = {
 	DEFINE_RES_IRQ(gic_spi(120)),
 };
 
-#define r8a7790_register_cmt(idx)					\
+#define r8a73a4_register_cmt(idx)					\
 	platform_device_register_resndata(NULL, "sh-cmt-48-gen2",	\
 					  idx, cmt##idx##_resources,	\
 					  ARRAY_SIZE(cmt##idx##_resources), \
@@ -189,7 +189,7 @@ static struct resource cmt1_resources[] = {
 
 void __init r8a73a4_add_dt_devices(void)
 {
-	r8a7790_register_cmt(1);
+	r8a73a4_register_cmt(1);
 }
 
 /* DMA */
-- 
2.1.1
