From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 21 Sep 2018 12:07:36 +0800
Subject: [PATCH 2/4] pinctrl: mediatek: add no eint function for pin define
In-Reply-To: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
References: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
Message-ID: <554196e837f622eea62d11602b7c88721d6a776d.1537502494.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mars Cheng <mars.cheng@mediatek.com>

Add NO_EINT_SUPPORT back to pinctrl-mtk-common-v2.h as the alias of
EINT_NA to indicate that some pin not capable of being controlled as eint
and that is required by pinctrl-paris based driver as old
pinctrl-mtk-common.h already had.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index b618042..991c1c5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -19,6 +19,7 @@
 #define MTK_PULLUP     1
 
 #define EINT_NA	U16_MAX
+#define NO_EINT_SUPPORT	EINT_NA
 
 #define PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs,      \
 		       _s_bit, _x_bits, _sz_reg, _fixed) {		\
-- 
2.7.4
