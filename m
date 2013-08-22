From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 22 Aug 2013 18:54:28 +0200
Subject: [PATCH 3/4] arm: atmel: sama5: enable kernel uncompress info
 output
In-Reply-To: <1372922202-28606-4-git-send-email-voice.shen@atmel.com>
References: <1372922202-28606-1-git-send-email-voice.shen@atmel.com>
 <1372922202-28606-4-git-send-email-voice.shen@atmel.com>
Message-ID: <20130822165428.GE18627@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:16 Thu 04 Jul     , Bo Shen wrote:
> enable kernel uncompress info output, which will show as following:
> ---8>---
> Uncompressing Linux... done, booting the kernel.
> ---<8---

squash it with the precedent patch

Best Regards,
J,
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>  arch/arm/mach-at91/include/mach/uncompress.h |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
> index 5659f7c..fe097e6 100644
> --- a/arch/arm/mach-at91/include/mach/uncompress.h
> +++ b/arch/arm/mach-at91/include/mach/uncompress.h
> @@ -94,6 +94,15 @@ static const u32 uarts_sam9x5[] = {
>  	0,
>  };
>  
> +static const u32 uarts_sama5[] = {
> +	AT91_BASE_DBGU1,
> +	SAMA5D3_BASE_USART0,
> +	SAMA5D3_BASE_USART1,
> +	SAMA5D3_BASE_USART2,
> +	SAMA5D3_BASE_USART3,
> +	0,
> +};
> +
>  static inline const u32* decomp_soc_detect(void __iomem *dbgu_base)
>  {
>  	u32 cidr, socid;
> @@ -123,6 +132,9 @@ static inline const u32* decomp_soc_detect(void __iomem *dbgu_base)
>  
>  	case ARCH_ID_AT91SAM9X5:
>  		return uarts_sam9x5;
> +
> +	case ARCH_ID_SAMA5D3:
> +		return uarts_sama5;
>  	}
>  
>  	/* at91sam9g10 */
> -- 
> 1.7.9.5
> 
