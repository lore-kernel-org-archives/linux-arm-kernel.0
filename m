From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 27 May 2014 16:53:44 +0530
Subject: [PATCH 1/1] ARM: keystone: Staticize keystone_restart
Message-ID: <1401189824-19814-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'keystone_restart' is used only in this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-keystone/keystone.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 59b8383cbdb0..4ac124b7e4e8 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -123,7 +123,7 @@ static const char *keystone_match[] __initconst = {
 	NULL,
 };
 
-void keystone_restart(enum reboot_mode mode, const char *cmd)
+static void keystone_restart(enum reboot_mode mode, const char *cmd)
 {
 	u32 val;
 
-- 
1.7.9.5
