From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 00:10:34 +0100
Subject: [PATCH 02/10] ARM: add dma_zone_size to the machine_desc structure
In-Reply-To: <1309919442-20451-2-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<1309919442-20451-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110706231034.GB8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 10:30:34PM -0400, Nicolas Pitre wrote:
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/include/asm/mach/arch.h |    4 ++++
>  arch/arm/kernel/setup.c          |    6 ++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 946f4d7..7b79a00 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -23,6 +23,10 @@ struct machine_desc {
>  
>  	unsigned int		nr_irqs;	/* number of IRQs */
>  
> +#ifdef CONFIG_ZONE_DMA
> +	unsigned long dma_zone_size;		/* size of DMA-able area */

Please try to keep the formatting the same.
