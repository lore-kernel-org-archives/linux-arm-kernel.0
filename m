From: horms@verge.net.au (Simon Horman)
Date: Mon, 24 Sep 2012 09:28:53 +0900
Subject: [PATCH] ARM: mach-shmobile: add FLCTL DMA slave definitions for
 sh7372
In-Reply-To: <1348315598-3980-1-git-send-email-hechtb@gmail.com>
References: <1348315598-3980-1-git-send-email-hechtb@gmail.com>
Message-ID: <20120924002853.GC1141@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ +CC linux-arm-kernel ]

On Sat, Sep 22, 2012 at 02:06:38PM +0200, Bastian Hecht wrote:
> SH7372 can use DMA with the FLCTL flash controller. Add required slave
> IDs and slave descriptors.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Thanks, applied to the boards branch of my renesas tree.

Unfortunately its a bit late to get this into 3.7 so I am currently
targeting it for 3.8.

> 
>  arch/arm/mach-shmobile/include/mach/sh7372.h |    4 ++++
>  arch/arm/mach-shmobile/setup-sh7372.c        |   20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
> index b59048e..0ad4220 100644
> --- a/arch/arm/mach-shmobile/include/mach/sh7372.h
> +++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
> @@ -452,6 +452,10 @@ enum {
>  	SHDMA_SLAVE_SCIF5_RX,
>  	SHDMA_SLAVE_SCIF6_TX,
>  	SHDMA_SLAVE_SCIF6_RX,
> +	SHDMA_SLAVE_FLCTL0_TX,
> +	SHDMA_SLAVE_FLCTL0_RX,
> +	SHDMA_SLAVE_FLCTL1_TX,
> +	SHDMA_SLAVE_FLCTL1_RX,
>  	SHDMA_SLAVE_SDHI0_RX,
>  	SHDMA_SLAVE_SDHI0_TX,
>  	SHDMA_SLAVE_SDHI1_RX,
> diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
> index 838a87b..64af6ea 100644
> --- a/arch/arm/mach-shmobile/setup-sh7372.c
> +++ b/arch/arm/mach-shmobile/setup-sh7372.c
> @@ -408,6 +408,26 @@ static const struct sh_dmae_slave_config sh7372_dmae_slaves[] = {
>  		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
>  		.mid_rid	= 0x3e,
>  	}, {
> +		.slave_id	= SHDMA_SLAVE_FLCTL0_TX,
> +		.addr		= 0xe6a30050,
> +		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
> +		.mid_rid	= 0x83,
> +	}, {
> +		.slave_id	= SHDMA_SLAVE_FLCTL0_RX,
> +		.addr		= 0xe6a30050,
> +		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
> +		.mid_rid	= 0x83,
> +	}, {
> +		.slave_id	= SHDMA_SLAVE_FLCTL1_TX,
> +		.addr		= 0xe6a30060,
> +		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
> +		.mid_rid	= 0x87,
> +	}, {
> +		.slave_id	= SHDMA_SLAVE_FLCTL1_RX,
> +		.addr		= 0xe6a30060,
> +		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
> +		.mid_rid	= 0x87,
> +	}, {
>  		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
>  		.addr		= 0xe6850030,
>  		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
