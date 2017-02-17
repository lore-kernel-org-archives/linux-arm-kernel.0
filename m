From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 17 Feb 2017 17:10:34 +0100
Subject: [PATCH 1/3] ARM: davinci: PM: Drop useless check for
 PM_SUSPEND_STANDBY
In-Reply-To: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1487347836-14427-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As DaVinci uses the standard suspend_valid_only_mem() for its
platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
callback will never be called with state equal to PM_SUSPEND_STANDBY.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-davinci/pm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 0afd201ab980464c..efb80354f3034d85 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -108,7 +108,6 @@ static int davinci_pm_enter(suspend_state_t state)
 	int ret = 0;
 
 	switch (state) {
-	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
 		davinci_pm_suspend();
 		break;
-- 
1.9.1
