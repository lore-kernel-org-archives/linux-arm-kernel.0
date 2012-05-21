From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 20 May 2012 21:12:09 -0400
Subject: kirkwood, nand, clocks and device-tree
In-Reply-To: <alpine.DEB.2.00.1205201352090.23719@marmot.wormnet.eu>
References: <87fwaxes25.fsf@lebrac.rtp-net.org>
 <20120520095110.GC12741@lunn.ch>
 <alpine.DEB.2.00.1205201352090.23719@marmot.wormnet.eu>
Message-ID: <20120521011209.GK24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2012 at 02:05:54PM +0100, Jamie Lentin wrote:
> board-dt.c should have an auxdata struct, to fix the name of
> "f4000000.nand" to orion_nand:-
> 
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 3cef3c7..6d45a07 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -24,6 +24,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
>  	{ }
>  };
> 
> +struct of_dev_auxdata kirkwood_dt_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("mrvl,orion-nand", KIRKWOOD_NAND_MEM_PHYS_BASE, "orion_nand", NULL),
> +	{ }
> +};
> +
>  static void __init kirkwood_dt_init(void)
>  {
>  	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
> @@ -61,7 +66,8 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("dlink,dns-kirkwood"))
>  		dnskw_init();
> 
> -	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
> +	of_platform_populate(NULL, kirkwood_dt_match_table,
> +			kirkwood_dt_auxdata_lookup, NULL);
>  }
> 
>  static const char *kirkwood_dt_board_compat[] = {
> 
> I should really submit this :) What should it be based on? A new

Yes, please do.  It's a good thing I haven't run across a nand-based
dreamplug yet. ;-)

As Andrew mentioned, until v3.5-rc1 comes out, please base on and
up-to-date arm-soc.

thx,

Jason.
