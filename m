From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Feb 2016 10:44:41 +0100
Subject: [PATCH 1/2] ARM: imx: Make reset_control_ops const
In-Reply-To: <1456393482-26318-1-git-send-email-p.zabel@pengutronix.de>
References: <1456393482-26318-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1456393482-26318-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx_src_ops structure is never modified. Make it const.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/src.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 45f7f4e..70b083f 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -73,7 +73,7 @@ static int imx_src_reset_module(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
-static struct reset_control_ops imx_src_ops = {
+static const struct reset_control_ops imx_src_ops = {
 	.reset = imx_src_reset_module,
 };
 
-- 
2.7.0
