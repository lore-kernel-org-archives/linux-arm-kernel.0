From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 30 Apr 2018 17:10:40 +0530
Subject: [PATCH 03/21] clk: sunxi-ng: Enable DE2_CCU for Allwinner 64-bit SoCs
In-Reply-To: <20180430114058.5061-1-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
Message-ID: <20180430114058.5061-4-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner 64-bit SoC like H5/A64 has DE2 CCU so enable them
as default.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/clk/sunxi-ng/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 79dfd296c3d1..1fffd3bf6ff3 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -58,6 +58,8 @@ config SUN8I_V3S_CCU
 
 config SUN8I_DE2_CCU
 	bool "Support for the Allwinner SoCs DE2 CCU"
+	default ARM64 && ARCH_SUNXI
+	depends on (DRM_SUN4I && (ARM64 && ARCH_SUNXI)) || COMPILE_TEST
 
 config SUN8I_R40_CCU
 	bool "Support for the Allwinner R40 CCU"
-- 
2.14.3
