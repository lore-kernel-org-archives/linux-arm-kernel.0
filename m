From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Dec 2013 21:34:41 +0100
Subject: [PATCH 2/7] ARM: msm: Add support for APQ8074 Dragonboard
In-Reply-To: <1387566560-23948-3-git-send-email-davidb@codeaurora.org>
References: <1387566560-23948-1-git-send-email-davidb@codeaurora.org>
 <1387566560-23948-3-git-send-email-davidb@codeaurora.org>
Message-ID: <201312202134.42027.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 December 2013, David Brown wrote:
> diff --git a/arch/arm/mach-msm/board-dt.c b/arch/arm/mach-msm/board-dt.c
> index 16e6183..1f11d93 100644
> --- a/arch/arm/mach-msm/board-dt.c
> +++ b/arch/arm/mach-msm/board-dt.c
> @@ -26,7 +26,16 @@ static const char * const msm_dt_match[] __initconst = {
>         NULL
>  };
>  
> +static const char * const apq8074_dt_match[] __initconst = {
> +       "qcom,apq8074-dragonboard",
> +       NULL
> +};
> +
>  DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
>         .smp = smp_ops(msm_smp_ops),
>         .dt_compat = msm_dt_match,
>  MACHINE_END
> +
> +DT_MACHINE_START(APQ_DT, "Qualcomm MSM (Flattened Device Tree)")
> +       .dt_compat = apq8074_dt_match,
> +MACHINE_END
> -- 

Why can't you reuse the MSM_DT definition and just add the dragonboard
to the list of compatible machines? The presence of the smp_ops pointer
should not matter if you don't support SMP.

	Arnd
