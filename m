From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 2 May 2013 11:52:02 +0100
Subject: [PATCH 09/10] ARM: ux500: Remove ux500-musb platform registation
 when booting with DT
In-Reply-To: <1366729394-11406-10-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-10-git-send-email-lee.jones@linaro.org>
Message-ID: <20130502105202.GJ25256@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Apr 2013, Lee Jones wrote:

> Now the ux500-musb driver has been enabled for Device Tree, there is no
> requirement to register it from platform code.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/cpu-db8500.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
> index 5a6b9ae..36ef6ed 100644
> --- a/arch/arm/mach-ux500/cpu-db8500.c
> +++ b/arch/arm/mach-ux500/cpu-db8500.c
> @@ -227,8 +227,6 @@ static struct device * __init u8500_of_init_devices(void)
>  {
>  	struct device *parent = db8500_soc_device_init();
>  
> -	db8500_add_usb(parent, usb_db8500_dma_cfg, usb_db8500_dma_cfg);
> -
>  	return parent;
>  }

Linus, poke.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
