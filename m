From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:37:02 +0900
Subject: [PATCH 5/5] ARM: shmobile: r8a7740: Fix TPU clock name
In-Reply-To: <cover.1374478336.git.horms+renesas@verge.net.au>
References: <cover.1374478336.git.horms+renesas@verge.net.au>
Message-ID: <93d8a6fbe69a629a7bb37bb546699a5c49963dc5.1374478336.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The TPU device is called renesas-tpu-pwm, not renesas_tpu_pwm. Fix the
clock name accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index de10fd7..f4265e5 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -596,7 +596,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("r8a7740-gether",		&mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
-	CLKDEV_DEV_ID("renesas_tpu_pwm",	&mstp_clks[MSTP304]),
+	CLKDEV_DEV_ID("renesas-tpu-pwm",	&mstp_clks[MSTP304]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
 	CLKDEV_DEV_ID("e6870000.sdhi",          &mstp_clks[MSTP415]),
-- 
1.8.2.1
