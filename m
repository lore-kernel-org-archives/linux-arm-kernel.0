From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 11 Jan 2018 11:04:51 +0800
Subject: [PATCH] clk: sunxi-ng: defaultly enable DE2 CCU for sun8i/sun50i
Message-ID: <20180111030451.9217-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As DE2 support for more SoCs are introducing, there's many reports that
the DE2 is not functional due to DE2 CCU code not included in kernel.

Defaultly enable DE2 CCU for sun8i/sun50i to reduce this kind of
problems.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 6427d0ebe2de..c2b04dcb6f18 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -60,6 +60,8 @@ config SUN8I_V3S_CCU
 
 config SUN8I_DE2_CCU
 	bool "Support for the Allwinner SoCs DE2 CCU"
+	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
+	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN8I_R40_CCU
 	bool "Support for the Allwinner R40 CCU"
-- 
2.14.2
