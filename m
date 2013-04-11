From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Apr 2013 17:15:00 +0900
Subject: [PATCH 1/2] ARM: shmobile: Add second I/O range for r8a7790 PFC
In-Reply-To: <1365668101-21723-1-git-send-email-horms+renesas@verge.net.au>
References: <1365668101-21723-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1365668101-21723-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add the GPIO I/O memory range to the r8a7790 PFC device.

This extra I/O memory range is needed when using the PFC
tables to drive both pin functions (using PINCTRL or
function GPIO for old code) and actual GPIO. The goal is
however to use a separate GPIO driver in the long run
and when that happens this extra I/O memory range can
be removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 481201a..cfccf6c 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -31,6 +31,7 @@
 
 static const struct resource pfc_resources[] = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
+	DEFINE_RES_MEM(0xe6050000, 0x5050),
 };
 
 void __init r8a7790_pinmux_init(void)
-- 
1.7.10.4
