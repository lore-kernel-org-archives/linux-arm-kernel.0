From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 11 Jun 2017 15:04:19 +0200
Subject: [PATCH v4 07/28] ARM64: Prepare Actions Semi S900
In-Reply-To: <20170606005426.26446-8-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-8-afaerber@suse.de>
Message-ID: <7aa77b69-a5ac-f5a8-0c9c-87cc94f6122e@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Add ARCH_ACTIONS.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>  
>  v2 -> v3:
>  * Selected clocksource driver
>  
>  v1 -> v2:
>  * Renamed ARCH_OWL to ARCH_ACTION (Arnd)
>  
>  arch/arm64/Kconfig.platforms | 6 ++++++
>  1 file changed, 6 insertions(+)

To make a start somewhere, given Daniel's ack for OWL_TIMER, I'm
applying this to my new linux-actions.git v4.13/arm64 branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/arm64

For arm I'm still giving Actions Semi a final chance to comment on the
vendor prefix and DT bindings (none on v3 and none for a week for v4).

Regards,
Andreas

> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 9a6f50fed239..7b0615161750 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -1,5 +1,11 @@
>  menu "Platform selection"
>  
> +config ARCH_ACTIONS
> +	bool "Actions Semi Platforms"
> +	select OWL_TIMER
> +	help
> +	  This enables support for the Actions Semiconductor S900 SoC family.
> +
>  config ARCH_SUNXI
>  	bool "Allwinner sunxi 64-bit SoC Family"
>  	select ARCH_HAS_RESET_CONTROLLER

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
