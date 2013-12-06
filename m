From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 7 Dec 2013 02:34:32 +0530
Subject: [PATCH v3] ARM: davinci: aemif: get rid of davinci-nand driver
 dependency on aemif
In-Reply-To: <1386267092-18615-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1386267092-18615-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52A23BE0.2000207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/5/2013 11:41 PM, Ivan Khoronzhuk wrote:

> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 7aa105b..98a66ff 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -432,6 +432,9 @@ static void __init mityomapl138_setup_nand(void)
>  {
>  	platform_add_devices(mityomapl138_devices,
>  				 ARRAY_SIZE(mityomapl138_devices));
> +
> +	if (davinci_aemif_setup(&mityomapl138_nandflash_device))
> +		pr_warn("%s: Cannot configure AEMIF.\n", __func__);
>  }

I must be missing something, but exactly why is this required for
board-mityomapl138.c?

Thanks,
Sekhar
