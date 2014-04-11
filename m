From: marex@denx.de (Marek Vasut)
Date: Fri, 11 Apr 2014 14:15:52 +0200
Subject: [PATCH] ARM: dts: imx6sl-evk: Add an entry for
 MX6SL_PAD_ECSPI1_SS0__GPIO4_IO11
In-Reply-To: <1397218179-3533-1-git-send-email-festevam@gmail.com>
References: <1397218179-3533-1-git-send-email-festevam@gmail.com>
Message-ID: <201404111415.52225.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 11, 2014 at 02:09:39 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> In case the bootloader has incorrectly configured the ALT mode of
> MX6SL_PAD_ECSPI1_SS0 pad, we end up with the following probe error:
> 
> m25p80 spi0.0: found mr25h256, expected m25p32
> m25p80 spi0.0: mr25h256 (32 Kbytes)
> 
> In order to avoid this issue, add an entry for MX6SL_PAD_ECSPI1_SS0 pad, so
> that kernel configures the ECSPI chip select as GPIO functionality, which
> results in correct SPI NOR probe.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sl-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts
> b/arch/arm/boot/dts/imx6sl-evk.dts index 864d8df..a8d9a93 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -282,6 +282,7 @@
>  				MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO	0x100b1
>  				MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI	0x100b1
>  				MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK	0x100b1
> +				MX6SL_PAD_ECSPI1_SS0__GPIO4_IO11	
0x80000000

Doesn't 0x80000000 mean "do not configure this pin, leave it as it was 
configured before" ?

Best regards,
Marek Vasut
