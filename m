From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 18:16:29 +0200
Subject: [GIT PULL 3/4] ARM: imx: device tree changes for 4.2
In-Reply-To: <1433145206-2508-3-git-send-email-shawn.guo@linaro.org>
References: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
 <1433145206-2508-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <3918834.Y7ttkc5iBm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 June 2015 15:53:25 Shawn Guo wrote:
> The i.MX device tree changes for 4.2:
>  - Add device tree for i.MX7D SoC and imx7d-sdb board
>  - New i.MX6 board support: Armadeus Systems APF6, Gateworks GW5510,
>    and aristainetos2 boards
>  - Change LVDS to use simple-panel for nitrogen6x and sabrelite boards
>  - Add Wifi/Bluetooth devices support for cubox-i board
>  - Remove unused regulators and correct OTG roles setting for
>    imx6sl-warp board
>  - Add I2C support for imx23-olinuxino board
>  - Move imx6qdl HDMI device to a better place
>  - Add power-domain for imx6qdl CODA device
> 
> 

Hi Shawn,

If it's not too much of a hassle, could you rebase the soc and dt branches,
so that only the addition of the dt-bindings header is shared between
them, rather than the whole imx/soc branch?

Also, could you fold this change into the patch that moves the gpt driver?

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3c15a49fdac9..fd43dbb5e47b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -278,7 +278,7 @@ config CLKSRC_PXA
 
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
-	depends on OF
+	depends on OF && COMMON_CLK
 	select CLKSRC_MMIO
 
 config H8300_TMR16

Without this, we get build errors for COMPILE_TEST.

	Arnd
