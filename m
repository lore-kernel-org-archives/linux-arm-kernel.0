From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 12:55:25 +0900
Subject: [PATCH 07/15] ARM: shmobile: add function declarations for sh7372 DT
 helper functions
In-Reply-To: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
References: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359086133-23357-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

sh7372_add_early_devices_dt() and sh7372_add_standard_devices_dt() are
defined as global functions in arch/arm/mach-shmobile/setup-sh7372.c,
but their declarations are missing. Add them to common.h, where similar
functions for this and other SoC types are already declared.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index a57439e..2d1686b 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -23,6 +23,8 @@ extern void sh7372_map_io(void);
 extern void sh7372_earlytimer_init(void);
 extern void sh7372_add_early_devices(void);
 extern void sh7372_add_standard_devices(void);
+extern void sh7372_add_early_devices_dt(void);
+extern void sh7372_add_standard_devices_dt(void);
 extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
 extern void sh7372_pm_init(void);
-- 
1.7.10.4
