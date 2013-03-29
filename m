From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 29 Mar 2013 14:48:52 -0400
Subject: [PATCH 2/4] ARM: kirkwood: add device node entries for the
 gigabit interfaces
In-Reply-To: <1364580879-4297-3-git-send-email-florian@openwrt.org>
References: <1364580879-4297-1-git-send-email-florian@openwrt.org>
 <1364580879-4297-3-git-send-email-florian@openwrt.org>
Message-ID: <20130329184852.GM13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 07:14:37PM +0100, Florian Fainelli wrote:
> This patch modifies kirkwood.dtsi to specify the various gigabit
> interfaces nodes available on kirkwood devices. They are disabled by
> default and should be enabled on a per-board basis. egiga0 and egiga1
> aliases are defined for convenience. The mdio node is also present and
> should be enabled on a per-board basis as well.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/arm/boot/dts/kirkwood.dtsi |   46 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/common.c |    4 ++--
>  2 files changed, 48 insertions(+), 2 deletions(-)
> 
...
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 49792a0..a606f9f 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -251,8 +251,8 @@ void __init kirkwood_clk_init(void)
>  	/* clkdev entries, mapping clks to devices */
>  	orion_clkdev_add(NULL, "orion_spi.0", runit);
>  	orion_clkdev_add(NULL, "orion_spi.1", runit);
> -	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".0", ge0);
> -	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".1", ge1);
> +	orion_clkdev_add("0", MV643XX_ETH_NAME ".0", ge0);
> +	orion_clkdev_add("1", MV643XX_ETH_NAME ".1", ge1);

Your first patch is going to go through David's tree, and I'd like to
prevent any hard dependency between his tree and arm-soc.  Can this
change be pulled out and applied separately?  At first glance, it looks
like a fix to match sata and pcie.

thx,

Jason.
