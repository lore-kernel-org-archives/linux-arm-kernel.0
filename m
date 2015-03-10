From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Mar 2015 19:59:20 +0800
Subject: [PATCH v5 09/12] mfd: axp20x: Enable AXP22X regulators
In-Reply-To: <1425988764-23618-1-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
Message-ID: <1425988764-23618-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the axp20x-regulators driver supports different variants of the
AXP family, we can enable regulator support for AXP22X without the risk
of incorrectly configuring regulators.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0ec27d5023df..8d2dbb7eb588 100644
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
