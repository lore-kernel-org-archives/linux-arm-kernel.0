From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 20 Apr 2011 12:10:34 -0500
Subject: [RFC PATCH 11/23] at91: Make watchdog device common
In-Reply-To: <1303261827-27730-13-git-send-email-ryan@bluewatersys.com>
References: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>
	<1303261827-27730-13-git-send-email-ryan@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D23AB86B@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 19, 2011 6:10 PM, Ryan Mallon wrote:
>
> The code for the watchdog device for each of the at91 variants is
> identical. Remove it from each variant and replace them with a single
> version in devices.c
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---

[snip]

> diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
> index 2828e7e..20fe358 100644
> --- a/arch/arm/mach-at91/at572d940hf_devices.c
> +++ b/arch/arm/mach-at91/at572d940hf_devices.c

[snip]
 
> @@ -538,17 +518,3 @@ void __init at572d940hf_init_devices(void)
>  {
>  	at91_init_devices(&at572d940hf_device_table);
>  }
> -
> -/* -------------------------------------------------------------------- */
> -
> -/*
> - * These devices are always present and don't need any board-specific
> - * setup.
> - */
> -static int __init at91_add_standard_devices(void)
> -{
> -	at91_add_device_watchdog();
> -	return 0;
> -}
> -
> -arch_initcall(at91_add_standard_devices);

Ryan,

I would suggest leaving the various at91_add_standard_devices functions in until
all the other patches are applied.  Add one more patch to the series to finally
rip them out after all the conversions are complete.

Regards,
Hartley
