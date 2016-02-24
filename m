From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 24 Feb 2016 12:46:58 -0500
Subject: [PATCH v3 6/6] arm: lpc32xx: phy3250 remove restart hook
In-Reply-To: <1456336018-6620-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456336018-6620-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1456336018-6620-7-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Remove the restart hook assignment from phy3250;
this functionality is now managed by
the pnx4008 watchdog driver.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Note:
This patch was generated with the option "--unified=2" to ensure
it can be apply before or after the following git pull request
for the LPC32xx platform:
- http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477137
- http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477138

Changes from v2 to v3:
- new patch in v3.

 arch/arm/mach-lpc32xx/phy3250.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 65ec92c..26de053 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -264,4 +264,3 @@ DT_MACHINE_START(LPC32XX_DT, "LPC32XX SoC (Flattened Device Tree)")
 	.init_machine	= lpc3250_machine_init,
 	.dt_compat	= lpc32xx_dt_compat,
-	.restart	= lpc23xx_restart,
 MACHINE_END
-- 
1.8.3.1
