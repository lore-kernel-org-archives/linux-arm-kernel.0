From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 13 Jun 2012 12:32:09 +0200
Subject: [PATCH] mach-dove: Fixup ge00 initialisation
In-Reply-To: <1339509585-62405-1-git-send-email-hare@suse.de>
References: <1339509585-62405-1-git-send-email-hare@suse.de>
Message-ID: <20120613103209.GA23018@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 03:59:45PM +0200, Hannes Reinecke wrote:
> The last argument of orion_ge00_init() is actually the error
> interrupt, so we should be using the correct value here.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  arch/arm/mach-dove/common.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index f7d639b..a9d0708 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -101,8 +101,8 @@ void __init dove_ehci1_init(void)
>   ****************************************************************************/
>  void __init dove_ge00_init(struct mv643xx_eth_platform_data *eth_data)
>  {
> -	orion_ge00_init(eth_data,
> -			DOVE_GE00_PHYS_BASE, IRQ_DOVE_GE00_SUM, 0);
> +	orion_ge00_init(eth_data, DOVE_GE00_PHYS_BASE,
> +			IRQ_DOVE_GE00_SUM, IRQ_DOVE_GE00_ERR);
>  }
>  
>  /***************************************************************************

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
