From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 19 Jun 2013 21:30:01 +0400
Subject: [RFC PATCH 6/6] ARM: OMAP3: Enable Hardware Save and Restore
 for USB Host
In-Reply-To: <1371650753-11452-7-git-send-email-rogerq@ti.com>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
 <1371650753-11452-7-git-send-email-rogerq@ti.com>
Message-ID: <51C1EA99.2020401@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/19/2013 06:05 PM, Roger Quadros wrote:

> To ensure hardware context is restored while resuming from
> OFF mode we need to enable the Hardware SAR bit for the
> USB Host power domain.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   arch/arm/mach-omap2/powerdomains3xxx_data.c |    8 +-------
>   1 files changed, 1 insertions(+), 7 deletions(-)

> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> index f0e14e9..9554d2b 100644
> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> @@ -289,13 +289,7 @@ static struct powerdomain usbhost_pwrdm = {
>   	.prcm_offs	  = OMAP3430ES2_USBHOST_MOD,
>   	.pwrsts		  = PWRSTS_OFF_RET_ON,
>   	.pwrsts_logic_ret = PWRSTS_RET,
> -	/*
> -	 * REVISIT: Enabling usb host save and restore mechanism seems to
> -	 * leave the usb host domain permanently in ACTIVE mode after
> -	 * changing the usb host power domain state from OFF to active once.
> -	 * Disabling for now.
> -	 */
> -	/*.flags	  = PWRDM_HAS_HDWR_SAR,*/ /* for USBHOST ctrlr only */
> +	.flags	  = PWRDM_HAS_HDWR_SAR, /* for USBHOST ctrlr only */

    Looks like you're not indenting = right, in accordance to the other 
fields...

>   	.banks		  = 1,
>   	.pwrsts_mem_ret	  = {
>   		[0] = PWRSTS_RET, /* MEMRETSTATE */
>

WBR, Sergei
