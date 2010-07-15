From: tbm@cyrius.com (Martin Michlmayr)
Date: Thu, 15 Jul 2010 21:26:21 +0100
Subject: [PATCH 2/2] set packet size limit for the mv643xx csum offloading
In-Reply-To: <1275827336-31111-2-git-send-email-saeed@marvell.com>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<1275827336-31111-2-git-send-email-saeed@marvell.com>
Message-ID: <20100715202621.GA772@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Saeed Bishara <saeed@marvell.com> [2010-06-06 15:28]:
> The mv643xx ethernet controller limits the packet size for the TX
> checksum offloading. this patch sets this limits for the needed
> devices.

I noticed that patch 1/2 has gone into mainline but I cannot find 2/2
in any tree.  Saeed, can you add the definition for Loki that someone
pointed out (9*1024) and resubmit?


> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  arch/arm/mach-dove/common.c     |    1 +
>  arch/arm/mach-kirkwood/common.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index 5da2cf4..473ce0b 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -149,6 +149,7 @@ void __init dove_ehci1_init(void)
>  struct mv643xx_eth_shared_platform_data dove_ge00_shared_data = {
>  	.t_clk		= 0,
>  	.dram		= &dove_mbus_dram_info,
> +	.tx_csum_limit	= 1600,
>  };
>  
>  static struct resource dove_ge00_shared_resources[] = {
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 4ccfdf9..c4bd8cb 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -114,6 +114,7 @@ void __init kirkwood_ehci_init(void)
>   ****************************************************************************/
>  struct mv643xx_eth_shared_platform_data kirkwood_ge00_shared_data = {
>  	.dram		= &kirkwood_mbus_dram_info,
> +	.tx_csum_limit	= 1600,
>  };
>  
>  static struct resource kirkwood_ge00_shared_resources[] = {
> -- 
> 1.6.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Martin Michlmayr
http://www.cyrius.com/
