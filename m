From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Tue, 12 Dec 2017 14:24:19 +0800
Subject: [PATCH v2 2/4] pinctrl: mediatek: cleanup for placing all drivers
 under the menu
In-Reply-To: <cover.1513059081.git.sean.wang@mediatek.com>
References: <cover.1513059081.git.sean.wang@mediatek.com>
Message-ID: <fc13c7249505784c1f89a2e0775bb9a75cd38c3f.1513059081.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Since lots of MediaTek drivers had been added, it seems slightly better
for that adding cleanup for placing MediaTek pinctrl drivers under the
independent menu as other kinds of drivers usually was done.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index fac9866..03b3023 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -1,4 +1,5 @@
-if ARCH_MEDIATEK || COMPILE_TEST
+menu "MediaTek pinctrl drivers"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 
 config PINCTRL_MTK
 	bool
@@ -46,4 +47,4 @@ config PINCTRL_MT6397
 	default MFD_MT6397
 	select PINCTRL_MTK
 
-endif
+endmenu
-- 
2.7.4
