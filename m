From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Jan 2014 13:18:28 +0100
Subject: [PATCH 04/18] mfd: max14577: Add of_compatible to extcon mfd_cell
In-Reply-To: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1390911522-28209-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of_compatible ("maxim,max14577-muic") to the mfd_cell for extcon
driver. If entry with such compatible is present in the DTS, the extcon
driver will have of_node set.

This may be useful for extcon consumers and it is documented in
bindings documentation.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/max14577.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index ac514fb2b877..2ac2f2d7cea6 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -25,7 +25,10 @@
 #include <linux/mfd/max14577-private.h>
 
 static struct mfd_cell max14577_devs[] = {
-	{ .name = "max14577-muic", },
+	{
+		.name = "max14577-muic",
+		.of_compatible = "maxim,max14577-muic",
+	},
 	{
 		.name = "max14577-regulator",
 		.of_compatible = "maxim,max14577-regulator",
-- 
1.7.9.5
