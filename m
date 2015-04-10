From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Apr 2015 12:09:06 +0800
Subject: [PATCH RESEND v6 6/6] mfd: axp20x: Enable AXP22X regulators
In-Reply-To: <1428638946-24890-1-git-send-email-wens@csie.org>
References: <1428638946-24890-1-git-send-email-wens@csie.org>
Message-ID: <1428638946-24890-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the axp20x-regulators driver supports different variants of the
AXP family, we can enable regulator support for AXP22X without the risk
of incorrectly configuring regulators.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index cfbb7d7aead6..6df91556faf3 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -370,6 +370,8 @@ static struct mfd_cell axp22x_cells[] = {
 		.name			= "axp20x-pek",
 		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
 		.resources		= axp22x_pek_resources,
+	}, {
+		.name			= "axp20x-regulator",
 	},
 };
 
-- 
2.1.4
