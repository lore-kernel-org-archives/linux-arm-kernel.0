From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 14 Feb 2017 16:41:57 -0800
Subject: [PATCH] soc: bcm: brcmstb: Match additional compatible strings
Message-ID: <20170215004159.11096-1-florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>

Match all known sun-top-ctrl compatible strings from our MIPS chips
counterparts. This allows us to properly report the SoC information to
user-space through our SoC driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Ralf, James,

I usually take patches touching this file through an ARM SoC pull request,
posting to linux-mips for people working on BMIPS STB to get a chance to review
this.

Thanks!

 drivers/soc/bcm/brcmstb/common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 94e7335553f4..b6195fdf0d00 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -41,6 +41,15 @@ bool soc_is_brcmstb(void)
 }
 
 static const struct of_device_id sun_top_ctrl_match[] = {
+	{ .compatible = "brcm,bcm7125-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7346-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7358-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7360-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7362-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7420-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7425-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7429-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7425-sun-top-ctrl", },
 	{ .compatible = "brcm,brcmstb-sun-top-ctrl", },
 	{ }
 };
-- 
2.11.0
