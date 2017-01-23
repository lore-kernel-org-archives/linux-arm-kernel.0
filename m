From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 23 Jan 2017 11:54:45 +0800
Subject: [PATCH 4/4] mfd: mt6397: Add MT6323 LED support into MT6397 driver
In-Reply-To: <1485143685-11808-1-git-send-email-sean.wang@mediatek.com>
References: <1485143685-11808-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1485143685-11808-5-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add compatible string as "mt6323-led" that will make
the OF core spawn child devices for the LED subnode
of that MT6323 MFD device.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/mfd/mt6397-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index e14d8b0..8e601c8 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -48,6 +48,10 @@
 		.name = "mt6323-regulator",
 		.of_compatible = "mediatek,mt6323-regulator"
 	},
+	{
+		.name = "mt6323-led",
+		.of_compatible = "mediatek,mt6323-led"
+	},
 };
 
 static const struct mfd_cell mt6397_devs[] = {
-- 
1.9.1
