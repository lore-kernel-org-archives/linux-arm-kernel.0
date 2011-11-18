From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Fri, 18 Nov 2011 03:44:30 +0000
Subject: [PATCH 2/2] ARM: mx5: add __initconst for fec pdata
In-Reply-To: <1321027746-5906-2-git-send-email-b29396@freescale.com>
References: <1321027746-5906-1-git-send-email-b29396@freescale.com>
 <1321027746-5906-2-git-send-email-b29396@freescale.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722E4637@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Dong Aisheng
> Sent: Saturday, November 12, 2011 12:09 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: kernel at pengutronix.de; s.hauer at pengutronix.de; w.sang at pengutronix.de;
> Guo Shawn-R65073; u.kleine-koenig at pengutronix.de
> Subject: [PATCH 2/2] ARM: mx5: add __initconst for fec pdata
>

Ping.
Any tag or comment for this one?

> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_evk.c  |    2 +-
>  arch/arm/mach-mx5/board-mx53_loco.c |    2 +-
>  arch/arm/mach-mx5/board-mx53_smd.c  |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-
> mx5/board-mx53_evk.c
> index 6a3e616..bc3a636 100644
> --- a/arch/arm/mach-mx5/board-mx53_evk.c
> +++ b/arch/arm/mach-mx5/board-mx53_evk.c
> @@ -106,7 +106,7 @@ static inline void mx53_evk_fec_reset(void)
>  	gpio_set_value(MX53_EVK_FEC_PHY_RST, 1);  }
> 
> -static struct fec_platform_data mx53_evk_fec_pdata = {
> +static const struct fec_platform_data mx53_evk_fec_pdata __initconst =
> +{
>  	.phy = PHY_INTERFACE_MODE_RMII,
>  };
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-
> mx5/board-mx53_loco.c
> index 7149416..d269ef3 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -242,7 +242,7 @@ static inline void mx53_loco_fec_reset(void)
>  	gpio_set_value(LOCO_FEC_PHY_RST, 1);
>  }
> 
> -static struct fec_platform_data mx53_loco_fec_data = {
> +static const struct fec_platform_data mx53_loco_fec_data __initconst =
> +{
>  	.phy = PHY_INTERFACE_MODE_RMII,
>  };
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-
> mx5/board-mx53_smd.c
> index e64fd2c..6a1fe88 100644
> --- a/arch/arm/mach-mx5/board-mx53_smd.c
> +++ b/arch/arm/mach-mx5/board-mx53_smd.c
> @@ -103,7 +103,7 @@ static inline void mx53_smd_fec_reset(void)
>  	gpio_set_value(SMD_FEC_PHY_RST, 1);
>  }
> 
> -static struct fec_platform_data mx53_smd_fec_data = {
> +static const struct fec_platform_data mx53_smd_fec_data __initconst = {
>  	.phy = PHY_INTERFACE_MODE_RMII,
>  };
> 
> --
> 1.7.0.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
