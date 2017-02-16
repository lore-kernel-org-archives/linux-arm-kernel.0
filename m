From: chris.brandt@renesas.com (Chris Brandt)
Date: Thu, 16 Feb 2017 11:17:41 -0500
Subject: [PATCH v4 2/3] ARM: shmobile: r7s72100: Enable L2 cache
In-Reply-To: <20170216161742.29320-1-chris.brandt@renesas.com>
References: <20170216161742.29320-1-chris.brandt@renesas.com>
Message-ID: <20170216161742.29320-3-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though L2C is specified in the DT, you still need to add the aux
settings in the machine_desc.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
* removed dummy l2c_write_sec function
---
 arch/arm/mach-shmobile/setup-r7s72100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index d46639f..319ca95 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -26,6 +26,8 @@ static const char *const r7s72100_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(R7S72100_DT, "Generic R7S72100 (Flattened Device Tree)")
+	.l2c_aux_val    = 0,
+	.l2c_aux_mask   = ~0,
 	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r7s72100_boards_compat_dt,
-- 
2.10.1
