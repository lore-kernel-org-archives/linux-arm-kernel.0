From: nm@ti.com (Nishanth Menon)
Date: Tue, 08 Mar 2011 07:37:49 +0530
Subject: [PATCH V2 3/3] OMAP4: Add IVA OPP enteries.
In-Reply-To: <1299318746-21438-1-git-send-email-shweta.gulati@ti.com>
References: <1299318746-21438-1-git-send-email-shweta.gulati@ti.com>
Message-ID: <4D758F75.6090807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shweta Gulati wrote, on 03/05/2011 03:22 PM:
> This Patch adds OPP enteries for IVA  in OMAP4 OPP Table
>
> Tested on OMAP4430 SDP Board.
>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>   arch/arm/mach-omap2/opp4xxx_data.c |    8 +++++++-
>   1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> index 36a4517..ba5eddd 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -78,7 +78,13 @@ static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
>   	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50_UV),
>   	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
>   	OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4430_VDD_CORE_OPP100_UV),
> -	/* TODO: add IVA, DSP, aess, fdif, gpu */
> +	/* IVA OPP1 - OPP50 */
> +	OPP_INITIALIZER("iva", true, 133000000, OMAP4430_VDD_IVA_OPP50_UV),
> +	/* IVA OPP2 - OPP100 */
> +	OPP_INITIALIZER("iva", true, 266100000, OMAP4430_VDD_IVA_OPP100_UV),
> +	/* IVA OPP3 - OPP-Turbo */
> +	OPP_INITIALIZER("iva", false, 332000000, OMAP4430_VDD_IVA_OPPTURBO_UV),
> +	/* TODO: add DSP, aess, fdif, gpu */
>   };
>
>   /**
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
