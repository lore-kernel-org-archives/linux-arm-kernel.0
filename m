From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Jul 2013 01:36:14 -0700
Subject: [PATCH 2/8] ARM: DRA7: Update SRAM details
In-Reply-To: <1373354873-12359-3-git-send-email-rnayak@ti.com>
References: <1373354873-12359-1-git-send-email-rnayak@ti.com>
 <1373354873-12359-3-git-send-email-rnayak@ti.com>
Message-ID: <20130709083613.GD5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130709 00:34]:
> DRA7xx devices have 512K of SRAM for both secure and non-secure
> devices.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> ---
>  arch/arm/mach-omap2/sram.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
> index 4bd0968..67d4277 100644
> --- a/arch/arm/mach-omap2/sram.c
> +++ b/arch/arm/mach-omap2/sram.c
> @@ -38,6 +38,7 @@
>  #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
>  #endif
>  #define OMAP5_SRAM_PA		0x40300000
> +#define DRA7_SRAM_PA		OMAP4_SRAM_PA
>  
>  #define SRAM_BOOTLOADER_SZ	0x00
>  
> @@ -111,6 +112,9 @@ static void __init omap_detect_sram(void)
>  		} else if (soc_is_omap54xx()) {
>  			omap_sram_start = OMAP5_SRAM_PA;
>  			omap_sram_size = SZ_128K; /* 128KB */
> +		} else if (soc_is_dra7xx()) {
> +			omap_sram_start = DRA7_SRAM_PA;
> +			omap_sram_size = SZ_512K; /* 512KB */
>  		} else {
>  			omap_sram_start = OMAP2_SRAM_PUB_PA;
>  			omap_sram_size = 0x800; /* 2K */
> @@ -131,6 +135,9 @@ static void __init omap_detect_sram(void)
>  		} else if (soc_is_omap54xx()) {
>  			omap_sram_start = OMAP5_SRAM_PA;
>  			omap_sram_size = SZ_128K; /* 128KB */
> +		} else if (soc_is_dra7xx()) {
> +			omap_sram_start = DRA7_SRAM_PA;
> +			omap_sram_size = SZ_512K; /* 512KB */
>  		} else {
>  			omap_sram_start = OMAP2_SRAM_PA;
>  			if (cpu_is_omap242x())

This again reminds me that we should move omaps to use
drivers/misc/sram.c. Other than that, this set looks good
to me.

Regards,

Tony
