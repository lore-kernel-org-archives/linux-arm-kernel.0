From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  3 Jul 2014 16:14:58 +0200
Subject: [PATCH 14/18] AT91: Remove poweroff code
In-Reply-To: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1404396906-25194-26-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all the SoC have been converted to use the new poweroff driver, we can
remove the poweroff code defined in mach-at91.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/setup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 69967c21d5c0..7124b0334bb1 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -321,17 +321,11 @@ void __init at91_map_io(void)
 
 void __iomem *at91_shdwc_base = NULL;
 
-static void at91sam9_poweroff(void)
-{
-	at91_shdwc_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
-}
-
 void __init at91_ioremap_shdwc(u32 base_addr)
 {
 	at91_shdwc_base = ioremap(base_addr, 16);
 	if (!at91_shdwc_base)
 		panic(pr_fmt("Impossible to ioremap at91_shdwc_base\n"));
-	pm_power_off = at91sam9_poweroff;
 }
 
 void __iomem *at91_rstc_base;
-- 
2.0.1
