From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 12:33:28 +0200
Subject: [PATCH 3/9] arm: mvebu: mark functions of armada-370-xp.c as static
In-Reply-To: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369132414-18959-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the functions in armada-370-xp.c are called from the
DT_MACHINE_START function pointers, so there is no need for them to be
visible outside of this file, and we therefore mark them as static.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 42a4cb3..bfe337d 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -38,18 +38,18 @@ static struct map_desc armada_370_xp_io_desc[] __initdata = {
 	},
 };
 
-void __init armada_370_xp_map_io(void)
+static void __init armada_370_xp_map_io(void)
 {
 	iotable_init(armada_370_xp_io_desc, ARRAY_SIZE(armada_370_xp_io_desc));
 }
 
-void __init armada_370_xp_timer_and_clk_init(void)
+static void __init armada_370_xp_timer_and_clk_init(void)
 {
 	mvebu_clocks_init();
 	armada_370_xp_timer_init();
 }
 
-void __init armada_370_xp_init_early(void)
+static void __init armada_370_xp_init_early(void)
 {
 	char *mbus_soc_name;
 
-- 
1.7.9.5
