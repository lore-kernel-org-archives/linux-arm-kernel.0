From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 29 Mar 2011 16:45:10 -0300
Subject: [PATCH 2/2] ARM: mxs/mach-mx23evk: Set the initial value on
	gpio_request_one
In-Reply-To: <1301427910-31726-1-git-send-email-fabio.estevam@freescale.com>
References: <1301427910-31726-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1301427910-31726-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code does not set the GPIO value to zero as mentioned in the comment.

Fix it by setting the initial GPIO value to zero.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

I do not have the hardware to test it, but I fixed it based on the comment.

 arch/arm/mach-mxs/mach-mx23evk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index 214e5b6..3c2de33 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -148,7 +148,7 @@ static void __init mx23evk_init(void)
 	mx23_add_auart0();
 
 	/* power on mmc slot by writing 0 to the gpio */
-	ret = gpio_request_one(MX23EVK_MMC0_SLOT_POWER, GPIOF_DIR_OUT,
+	ret = gpio_request_one(MX23EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
 			       "mmc0-slot-power");
 	if (ret)
 		pr_warn("failed to request gpio mmc0-slot-power: %d\n", ret);
-- 
1.6.0.4
