From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  3 Jan 2018 12:01:08 -0800
Subject: [PATCH v3 16/22] nvmem: meson-efuse: Do no gate COMPILE_TEST with
 MESON_SM
In-Reply-To: <20180103200114.23922-1-andrew.smirnov@gmail.com>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
Message-ID: <20180103200114.23922-17-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Being able to build this driver when COMPILE_TEST is selected is still
useful even when MESON_SM is not selected, since selecting this
driver as a module and doing "make modules" will result in successful
build and would detect trivial coding errors. For an example of type
of errors that could be prevented see [1] and [2]

[1] lkml.kernel.org/r/20171227225956.14442-12-andrew.smirnov at gmail.com
[2] https://marc.info/?l=linux-arm-kernel&m=151461599104358&w=2

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy at gmail.com
Cc: linux-kernel at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ff505af064ba..42e84e1b2a26 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -147,7 +147,7 @@ config NVMEM_VF610_OCOTP
 
 config MESON_EFUSE
 	tristate "Amlogic Meson GX eFuse Support"
-	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
+	depends on (ARCH_MESON && MESON_SM) || COMPILE_TEST
 	help
 	  This is a driver to retrieve specific values from the eFuse found on
 	  the Amlogic Meson GX SoCs.
-- 
2.14.3
