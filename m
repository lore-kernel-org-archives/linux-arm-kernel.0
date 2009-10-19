From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2009 14:58:42 +0100
Subject: [PATCH 01/46] DaVinci: DM365: SDIO interrupt resource correction
In-Reply-To: <1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20091019135842.GA13614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shouldn't this be targetted for -rc?

If it's a bug fix, it should go for rc and stable releases, not the
next kernel.

On Fri, Oct 16, 2009 at 12:09:05PM -0700, Kevin Hilman wrote:
> From: Phaneendra Kumar <phani@embwise.com>
> 
> This patch fixes a typo/bug in the DM365 SDIO interrupt assignment
> 
> Signed-off-by: Sandeep Paulraj <s-paulraj@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-davinci/devices.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
> index a55b650..34dc0e9 100644
> --- a/arch/arm/mach-davinci/devices.c
> +++ b/arch/arm/mach-davinci/devices.c
> @@ -177,7 +177,7 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
>  			mmcsd1_resources[0].start = DM365_MMCSD1_BASE;
>  			mmcsd1_resources[0].end = DM365_MMCSD1_BASE +
>  							SZ_4K - 1;
> -			mmcsd0_resources[2].start = IRQ_DM365_SDIOINT1;
> +			mmcsd1_resources[2].start = IRQ_DM365_SDIOINT1;
>  		} else
>  			break;
>  
> -- 
> 1.6.4.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
