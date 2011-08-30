From: jhovold@gmail.com (Johan Hovold)
Date: Tue, 30 Aug 2011 18:48:16 +0200
Subject: [PATCH 1/2 RESEND] OMAP2+: pm: fix typos
In-Reply-To: <87r543rkdk.fsf@ti.com>
References: <87r543rkdk.fsf@ti.com>
Message-ID: <1314722897-25040-1-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typos in comment and error message.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-omap2/pm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 3feb359..fd77cf4 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -163,11 +163,11 @@ err:
 }
 
 /*
- * This API is to be called during init to put the various voltage
+ * This API is to be called during init to set the various voltage
  * domains to the voltage as per the opp table. Typically we boot up
  * at the nominal voltage. So this function finds out the rate of
  * the clock associated with the voltage domain, finds out the correct
- * opp entry and puts the voltage domain to the voltage specifies
+ * opp entry and sets the voltage domain to the voltage specified
  * in the opp entry
  */
 static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
@@ -218,7 +218,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	return 0;
 
 exit:
-	printk(KERN_ERR "%s: Unable to put vdd_%s to its init voltage\n\n",
+	printk(KERN_ERR "%s: Unable to set vdd_%s to its init voltage\n\n",
 		__func__, vdd_name);
 	return -EINVAL;
 }
-- 
1.7.6
