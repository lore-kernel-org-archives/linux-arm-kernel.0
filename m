From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 26 Apr 2017 23:20:20 +0800
Subject: [PATCH v5 07/10] mfd: axp20x: add axp20x-regulator cell for AXP803
In-Reply-To: <20170426152023.41567-1-icenowy@aosc.io>
References: <20170426152023.41567-1-icenowy@aosc.io>
Message-ID: <20170426152023.41567-8-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As axp20x-regulator now supports AXP803, add a cell for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v5:
- Removed wrong snippet.
Changes in v4:
- Added a trailing comma for new cell, for easier further cell addition.
Changes in v3:
- Make the new cell one-liner.

 drivers/mfd/axp20x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 1dc6235778eb..917b6ddc4f15 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -848,7 +848,8 @@ static struct mfd_cell axp803_cells[] = {
 		.name			= "axp20x-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
-	}
+	},
+	{	.name			= "axp20x-regulator" },
 };
 
 static struct mfd_cell axp806_cells[] = {
-- 
2.12.2
