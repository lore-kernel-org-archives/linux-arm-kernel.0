From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:37 +0200
Subject: [PATCH v2 12/30] ARM: shmobile: r8a73a4: Rename cmt registration
 helper
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename r8a7790_register_cmt() as r8a73a4_register_cmt() to
reflect name of the SoC in use. The use of r8a7790 appears
to be due to historical sharing of code from that SoC.
Shared code is no longer used.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/mach-shmobile/setup-r8a73a4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 2e1ec5e..496ecf3 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -180,7 +180,7 @@ static struct resource cmt1_resources[] = {
 	DEFINE_RES_IRQ(gic_spi(120)),
 };
 
-#define r8a7790_register_cmt(idx)					\
+#define r8a73a4_register_cmt(idx)					\
 	platform_device_register_resndata(&platform_bus, "sh-cmt-48-gen2", \
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
2.0.0.rc2
