From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  2 Mar 2018 15:04:47 +0100
Subject: [PATCH v2] ARM: socfpga: PM: Drop useless check for PM_SUSPEND_STANDBY
Message-ID: <1519999487-15474-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As SoCFPGA uses the standard suspend_valid_only_mem() for its
platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
callback will never be called with state equal to PM_SUSPEND_STANDBY.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2:
  - Add Acked-by.
---
 arch/arm/mach-socfpga/pm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
index c378ab0c24317ccf..d4866788702cb87a 100644
--- a/arch/arm/mach-socfpga/pm.c
+++ b/arch/arm/mach-socfpga/pm.c
@@ -116,7 +116,6 @@ static int socfpga_pm_suspend(unsigned long arg)
 static int socfpga_pm_enter(suspend_state_t state)
 {
 	switch (state) {
-	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
 		outer_disable();
 		cpu_suspend(0, socfpga_pm_suspend);
-- 
2.7.4
