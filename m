From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Fri, 06 Nov 2015 22:42:41 +0100
Subject: [PATCH v3 4/4] ARM: BCM: Add SMP support for Broadcom 4708
In-Reply-To: <1446844273-6460-5-git-send-email-kapilh@broadcom.com>
References: <1446844273-6460-1-git-send-email-kapilh@broadcom.com>
 <1446844273-6460-5-git-send-email-kapilh@broadcom.com>
Message-ID: <563D1ED1.6050506@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2015 10:11 PM, Kapil Hali wrote:
> From: Jon Mason <jonmason@broadcom.com>
> 
> Add SMP support for Broadcom's 4708 SoCs.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> Tested-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Kapil Hali <kapilh@broadcom.com>

I tested this on a Netgear R6250 V1 (BCM4708) and SMP worked.

> ---
>  arch/arm/boot/dts/bcm4708.dtsi | 2 ++
>  arch/arm/mach-bcm/Kconfig      | 1 +
>  arch/arm/mach-bcm/Makefile     | 3 +++
>  3 files changed, 6 insertions(+)
> 

...

> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -54,6 +54,7 @@ config ARCH_BCM_NSP
>  config ARCH_BCM_5301X
>  	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
>  	select ARCH_BCM_IPROC

You activated ARM_ERRATA_764369 for NSP is this not needed for NS?


> +	select HAVE_SMP
>  	help
>  	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
>  

...
