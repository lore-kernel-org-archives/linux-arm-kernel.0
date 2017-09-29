From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 29 Sep 2017 11:22:00 +0100
Subject: [PATCH v2 1/4] rtc: pl031: constify amba_ids
In-Reply-To: <20170929102116.GX20805@n2100.armlinux.org.uk>
References: <20170929102116.GX20805@n2100.armlinux.org.uk>
Message-ID: <E1dxsQi-0006NV-EF@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AMBA device IDs should be marked const.  Make that so.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/rtc/rtc-pl031.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index e1687e19c59f..0d87b90b1903 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -446,7 +446,7 @@ static struct pl031_vendor_data stv2_pl031 = {
 	.irqflags = IRQF_SHARED | IRQF_COND_SUSPEND,
 };
 
-static struct amba_id pl031_ids[] = {
+static const struct amba_id pl031_ids[] = {
 	{
 		.id = 0x00041031,
 		.mask = 0x000fffff,
-- 
2.7.4
