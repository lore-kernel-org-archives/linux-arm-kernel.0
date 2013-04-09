From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue,  9 Apr 2013 10:57:21 +0200
Subject: [PATCH] mfd: ab8500-core: Add of_compatilbe property for ab8500-usb
Message-ID: <1365497841-4640-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of_comptabile string to the ab8500-usb cell to allow the driver to
grab properties from device-tree when available.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---

Hi Samuel,

this oneline allows the driver to grab regulators and other attributes
from device tree.

This is actually generated on top of -next, so it should apply cleanly on
your current mfd-next tree.  If it doesn't, I'll rebase on your updated
tree when available.

Thanks,
Fabio

 drivers/mfd/ab8500-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index f276352..4be1d0c 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1107,6 +1107,7 @@ static struct mfd_cell ab8500_devs[] = {
 	},
 	{
 		.name = "ab8500-usb",
+		.of_compatible = "stericsson,ab8500-usb",
 		.num_resources = ARRAY_SIZE(ab8500_usb_resources),
 		.resources = ab8500_usb_resources,
 	},
-- 
1.8.1.3
