From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 14:19:26 +0000
Subject: [PATCH 7/7] common.c:105 Variable 'gephy' is  never used.
In-Reply-To: <1426254264-5105-1-git-send-email-ameenali023@gmail.com>
References: <1426254264-5105-1-git-send-email-ameenali023@gmail.com>
Message-ID: <20150313141926.GM8656@n2100.arm.linux.org.uk>
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

NAK.  Just because some variable isn't read doesn't mean that you need
to dream up some way to make it used.

In any case, this is wrong because it will duplicate this entry:

>  	orion_clkdev_add(NULL, "mv643xx_eth_port.0", ge);

which means that 'gephy' will probably be returned instead of 'ge' for
this device - and will cause the ethernet to stop working.

Please leave the code as it was and ignore this assigned-to-but-unused
variable.  Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
