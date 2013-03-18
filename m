From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:48 +0900
Subject: [PATCH 38/43] ARM: shmobile: tidyup chip series definition order for
 r8a7740/r8a7779
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-39-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

move r8a7740_meram_workaround() to r8a7740 area
from r8a7779 area

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 1ca1ad9..86fcdf9 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -50,6 +50,7 @@ extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
 extern struct clk sh73a0_extalr_clk;
 
+extern void r8a7740_meram_workaround(void);
 extern void r8a7740_init_irq(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
@@ -69,8 +70,6 @@ extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
-extern void r8a7740_meram_workaround(void);
-
 extern void r8a7779_register_twd(void);
 
 #ifdef CONFIG_SUSPEND
-- 
1.7.10.4
