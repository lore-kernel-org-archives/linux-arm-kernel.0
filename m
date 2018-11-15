From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 15 Nov 2018 10:46:49 +0100
Subject: [PATCH] arm64: renesas: Enable GPIOLIB to allow GPIO driver selection
Message-ID: <20181115094649.16675-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

The R-Car GPIO driver cannot be enabled when Renesas SoC's ARCH configs
(ARCH_RENESAS, ARCH_R8A7795, ARCH_R8A7796 and ARCH_R8A77965) are enabled
only.

As GPIOs are a critical resource for proper operation on Renesas
platforms, this patch selects GPIOLIB, just like is done for other SoC
vendors, and on Renesas arm32 SoCs.

Reported-by: Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Improve patch description]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479334a43f5d..2eb02734ae4575a0 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -157,6 +157,7 @@ config ARCH_REALTEK
 
 config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
+	select GPIOLIB
 	select PINCTRL
 	select PM
 	select PM_GENERIC_DOMAINS
-- 
2.17.1
