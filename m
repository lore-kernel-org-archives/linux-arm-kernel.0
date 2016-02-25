From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Feb 2016 10:44:42 +0100
Subject: [PATCH 2/2] ARM: sirf: Make reset_control_ops const
In-Reply-To: <1456393482-26318-1-git-send-email-p.zabel@pengutronix.de>
References: <1456393482-26318-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1456393482-26318-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sirfsoc_rstc_ops structure is never modified. Make it const.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-prima2/rstc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 7c251eb..1cdb6167 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -54,7 +54,7 @@ static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
-static struct reset_control_ops sirfsoc_rstc_ops = {
+static const struct reset_control_ops sirfsoc_rstc_ops = {
 	.reset = sirfsoc_reset_module,
 };
 
-- 
2.7.0
