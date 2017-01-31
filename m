From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 31 Jan 2017 20:39:24 +0530
Subject: [PATCH v7 03/14] ARM: davinci: add a clock lookup entry for the
 SATA clock
In-Reply-To: <1485770531-6772-4-git-send-email-bgolaszewski@baylibre.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
 <1485770531-6772-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <91e96c08-c762-8022-8a34-31ec1f4106d8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 January 2017 03:32 PM, Bartosz Golaszewski wrote:
> This entry is needed for the ahci driver to get a functional clock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

This patch is not adding a clock lookup entry, but AUXDATA. I fixed the
subject line to:

ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for SATA

while applying.

Thanks,
Sekhar

>  arch/arm/mach-davinci/da8xx-dt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index 9ee44da..b83e5d1 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -42,6 +42,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci-da8xx", NULL),
>  	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
>  	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
> +	OF_DEV_AUXDATA("ti,da850-ahci", 0x01e18000, "ahci_da850", NULL),
>  	{}
>  };
>  
> 
