From: jbe@pengutronix.de (Juergen Beisert)
Date: Fri, 27 Apr 2012 13:19:05 +0200
Subject: [PATCH 1/2] netX: do this job prior the machine init code runs
In-Reply-To: <1335525546-13546-1-git-send-email-jbe@pengutronix.de>
References: <1335525546-13546-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1335525546-13546-2-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to make use of the registered devices here they should be
registered prior the platform code is called.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
---
 arch/arm/mach-netx/generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
index aa62746..5a7b575 100644
--- a/arch/arm/mach-netx/generic.c
+++ b/arch/arm/mach-netx/generic.c
@@ -185,7 +185,7 @@ static int __init netx_init(void)
 	return platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
-subsys_initcall(netx_init);
+postcore_initcall(netx_init);
 
 void netx_restart(char mode, const char *cmd)
 {
-- 
1.7.10
