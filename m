From: mjourdan@baylibre.com (Maxime Jourdan)
Date: Mon, 12 Nov 2018 17:46:54 +0100
Subject: [PATCH] drivers: soc: Allow building the amlogic drivers without
 ARCH_MESON
Message-ID: <20181112164654.28594-1-mjourdan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current condition makes it difficult to compile the amlogic/
drivers with COMPILE_TEST, or without ARCH_MESON in general.

Fixes kbuild errors with patch series that depend on drivers in that
directory, for instance the meson video decoder.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 446166ba0bec..90b686e586c6 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
-obj-$(CONFIG_ARCH_MESON)	+= amlogic/
+obj-y				+= amlogic/
 obj-y				+= qcom/
 obj-y				+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
-- 
2.19.1
