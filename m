From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 11:08:45 +0200
Subject: [PATCH 1/3] ARM: at91/PMC: sama5d3 family doesn't have a PLLB
In-Reply-To: <cover.1372064763.git.nicolas.ferre@atmel.com>
References: <cover.1372064763.git.nicolas.ferre@atmel.com>
Message-ID: <f914b67ea7c5af4bf24e93f092b5c2e31fac01bc.1372064763.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index da84188..085a79d 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -75,7 +75,8 @@ EXPORT_SYMBOL_GPL(at91_pmc_base);
 #define cpu_has_pllb()		(!(cpu_is_at91sam9rl() \
 				|| cpu_is_at91sam9g45() \
 				|| cpu_is_at91sam9x5() \
-				|| cpu_is_at91sam9n12()))
+				|| cpu_is_at91sam9n12() \
+				|| cpu_is_sama5d3()))
 
 #define cpu_has_upll()		(cpu_is_at91sam9g45() \
 				|| cpu_is_at91sam9x5() \
-- 
1.8.2.2
