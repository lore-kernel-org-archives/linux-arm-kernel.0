From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 28 Oct 2012 18:35:53 +0300
Subject: [PATCH 3/5] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1351438555-4668-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa27x_set_pwrmode is called from z2_power_off, so it shouldn't
be marked with __init.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/pxa27x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 8047ee0..88ff275 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -242,7 +242,7 @@ static struct clk_lookup pxa27x_clkregs[] = {
  */
 static unsigned int pwrmode = PWRMODE_SLEEP;
 
-int __init pxa27x_set_pwrmode(unsigned int mode)
+int pxa27x_set_pwrmode(unsigned int mode)
 {
 	switch (mode) {
 	case PWRMODE_SLEEP:
-- 
1.7.12.4
