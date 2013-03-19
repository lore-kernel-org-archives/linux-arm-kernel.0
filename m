From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:17:55 +0900
Subject: [PATCH 07/13] ARM: shmobile: parse DT and configure pinmux early on
 kzm9g-reference
In-Reply-To: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
References: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363659481-5922-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

GPIOs can be provided by the pinctrl subsystem, which can be initialised
by DT. Therefore DT has to be parsed before requesting GPIOs. Also non-DT
pinmux has to be configured early.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index caba1bb..add537c 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -47,6 +47,7 @@ static void __init kzm_init(void)
 {
 	sh73a0_add_standard_devices_dt();
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
+	sh73a0_pinmux_init();
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
-- 
1.7.10.4
