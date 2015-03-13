From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 13 Mar 2015 15:08:00 +0100
Subject: [PATCH 7/7] common.c:105 Variable 'gephy' is  never used.
In-Reply-To: <1426254264-5105-1-git-send-email-ameenali023@gmail.com>
References: <1426254264-5105-1-git-send-email-ameenali023@gmail.com>
Message-ID: <20150313140800.GY7311@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 03:44:24PM +0200, Ameen Ali wrote:
> Variable 'gephy' is assigned a value that is never used.
> 
> Signed-off-by : <AmeenALi023@gmail.com>
> ---
>  arch/arm/mach-dove/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index 0d1a892..115a413 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -113,7 +113,7 @@ static void __init dove_clk_init(void)
>  	orion_clkdev_add(NULL, "orion_spi.1", tclk);
>  	orion_clkdev_add(NULL, "orion_wdt", tclk);
>  	orion_clkdev_add(NULL, "mv64xxx_i2c.0", tclk);
> -
> +        orion_clkdev_add(NULL,"mv643xx_eth_port.0",gephy);

It looks like you have used spaces, not a tab?

Other than that, this looks sensible.

      Andrew

>  	orion_clkdev_add(NULL, "orion-ehci.0", usb0);
>  	orion_clkdev_add(NULL, "orion-ehci.1", usb1);
>  	orion_clkdev_add(NULL, "mv643xx_eth_port.0", ge);
> -- 
> 2.1.0
> 
