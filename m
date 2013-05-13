From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 13 May 2013 17:53:52 +0900
Subject: [PATCH 2/3] ARM: shmobile: r8a7790: Configure R-Car GPIO for
 IRQ_TYPE_EDGE_BOTH
In-Reply-To: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
References: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1368435233-8587-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"gpio-rcar: Support IRQ_TYPE_EDGE_BOTH" adds support to the R-Car GPIO
driver for IRQ_TYPE_EDGE_BOTH. As hardware support for this feature is
not universal for all SoCs a flag, has_both_edge_trigger, has been
added to the platform data of the driver to allow this feature to be
enabled.

As the r8a7790 SoC hardware supports this feature enable it.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has a build-time dependency on
"gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH".
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index eeef5f6..b461d93 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -45,6 +45,7 @@ static struct gpio_rcar_config r8a7790_gpio##idx##_platform_data = {	\
 	.irq_base	= 0,						\
 	.number_of_pins	= 32,						\
 	.pctl_name	= "pfc-r8a7790",				\
+	.has_both_edge_trigger = 1,					\
 };									\
 
 R8A7790_GPIO(0);
-- 
1.8.2.1
