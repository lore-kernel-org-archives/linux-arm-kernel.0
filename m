From: vincent.stehle@freescale.com (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Thu, 27 Jun 2013 14:49:27 +0200
Subject: [PATCH linux-next] ARM: keystone: fix compilation warning
Message-ID: <1372337367-6708-1-git-send-email-vincent.stehle@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following compilation warning:

  arch/arm/mach-keystone/keystone.c:74:2: warning: initialization from incompatible pointer type [enabled by default]
  arch/arm/mach-keystone/keystone.c:74:2: warning: (near initialization for ?__mach_desc_KEYSTONE.restart?) [enabled by default]

Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
Cc: Robin Holt <holt@sgi.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: trivial at kernel.org
---


Hi,

This warning was seen on linux-next tag next-20130627, with config ARM
multi_v7_defconfig.

Best regards,

V.


 arch/arm/mach-keystone/keystone.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index fe4d9ff..b661c5c 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -49,7 +49,7 @@ static const char *keystone_match[] __initconst = {
 	NULL,
 };
 
-void keystone_restart(char mode, const char *cmd)
+void keystone_restart(enum reboot_mode mode, const char *cmd)
 {
 	u32 val;
 
-- 
1.7.10.4
