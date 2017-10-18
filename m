From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Oct 2017 16:31:31 +0800
Subject: [PATCH v2 1/8] mfd: axp20x: Add axp20x-regulator cell for AXP813
In-Reply-To: <20171018083138.14517-1-wens@csie.org>
References: <20171018083138.14517-1-wens@csie.org>
Message-ID: <20171018083138.14517-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that axp20x-regulator supports AXP813, we can add a cell for it
to enable it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 336de66ca408..2468b431bb22 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -876,6 +876,8 @@ static struct mfd_cell axp813_cells[] = {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
+	}, {
+		.name			= "axp20x-regulator",
 	}
 };
 
-- 
2.14.2
