From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  8 Sep 2014 13:27:41 +0200
Subject: [PATCH] ARM: on a generic DT system: do not touch l2x0
Message-ID: <1410175661-31011-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set no bits, mask all bits in the AUX l2x0 register for the
default DT ARM system: if anything needs to be modified, it
should be done using DT bindings.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/devtree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 11c54de9f8cf..d989c0c2b221 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -207,6 +207,8 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 
 #ifdef CONFIG_ARCH_MULTIPLATFORM
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
+		.l2c_aux_val = 0x0,
+		.l2c_aux_mask = ~0x0,
 	MACHINE_END
 
 	mdesc_best = &__mach_desc_GENERIC_DT;
-- 
1.9.3
