From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Apr 2014 21:01:50 +0200
Subject: [PATCH 2/5] ARM: sun6i: Use CPU_METHOD_OF_DECLARE
In-Reply-To: <1397847713-28418-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397847713-28418-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1397847713-28418-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_METHOD_OF_DECLARE allows to bind the smp_ops to a set of cpus through the
enable-method property, instead of relying on the machine to define it. Switch
to it to get closer to an empty machine.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index 0c7dbce033cc..828f21126973 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -122,3 +122,4 @@ struct smp_operations sun6i_smp_ops __initdata = {
 	.smp_prepare_cpus	= sun6i_smp_prepare_cpus,
 	.smp_boot_secondary	= sun6i_smp_boot_secondary,
 };
+CPU_METHOD_OF_DECLARE(sun6i_smp, "allwinner,sun6i-a31", &sun6i_smp_ops);
-- 
1.9.1
