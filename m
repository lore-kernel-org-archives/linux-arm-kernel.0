From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 31 May 2011 11:55:31 -0500
Subject: [PATCH 3/4] ARM: ep93xx: add model detection for ts-7300 and
	ts-7400 boards
In-Reply-To: <1306665346-26657-4-git-send-email-ynezz@true.cz>
References: <1306665346-26657-1-git-send-email-ynezz@true.cz>
	<1306665346-26657-4-git-send-email-ynezz@true.cz>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F381FC48CF@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 29, 2011 3:36 AM, Petr ?tetiar wrote:
> Subject: [PATCH 3/4] ARM: ep93xx: add model detection for ts-7300 and ts-7400 boards
> 
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> ---
>  arch/arm/mach-ep93xx/include/mach/ts72xx.h |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/ts72xx.h b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
> index 0eabec6..ee7f875 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ts72xx.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
> @@ -20,6 +20,8 @@
>  #define TS72XX_MODEL_TS7200		0x00
>  #define TS72XX_MODEL_TS7250		0x01
>  #define TS72XX_MODEL_TS7260		0x02
> +#define TS72XX_MODEL_TS7300		0x03
> +#define TS72XX_MODEL_TS7400		0x04
>  
>  
>  #define TS72XX_OPTIONS_PHYS_BASE	0x22400000
> @@ -66,6 +68,16 @@ static inline int board_is_ts7260(void)
>  	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7260;
>  }
>  
> +static inline int board_is_ts7300(void)
> +{
> +	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7300;
> +}
> +
> +static inline int board_is_ts7400(void)
> +{
> +	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7400;
> +}
> +
>  static inline int is_max197_installed(void)
>  {
>  	return !!(__raw_readb(TS72XX_OPTIONS_VIRT_BASE) &

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
