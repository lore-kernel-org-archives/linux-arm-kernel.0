From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Oct 2012 09:13:23 +0100
Subject: [PATCH 10/10] ARM: ux500: Stop informing the regulator subsystem that
 we have full constraints
In-Reply-To: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349165603-24401-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator_has_full_constraints() call is not required if we
are booting with Device Tree as it's assumed in this case.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index f85659b..9f87b4d 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -325,9 +325,6 @@ static void __init u8500_init_machine(void)
 
 	/* automatically probe child nodes of db8500 device */
 	of_platform_populate(NULL, u8500_local_bus_nodes, u8500_auxdata_lookup, parent);
-
-	/* This board has full regulator constraints */
-	regulator_has_full_constraints();
 }
 
 static const char * u8500_dt_board_compat[] = {
-- 
1.7.9.5
