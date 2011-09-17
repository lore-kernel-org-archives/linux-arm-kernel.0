From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 17 Sep 2011 16:32:37 +0800
Subject: [PATCH v2 2/2] ARM: smp_scu: remove __init annotation from
	scu_enable()
In-Reply-To: <1315288107-14689-3-git-send-email-shawn.guo@linaro.org>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110917083236.GB26572@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 01:48:27PM +0800, Shawn Guo wrote:
> When Cortex-A9 MPCore resumes from Dormant or Shutdown modes,
> SCU needs to be re-enabled.  This patch removes __init annotation
> from function scu_enable(), so that platform resume procedure can
> call it to re-enable SCU.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Hi Russell,

Do you have any comment on this patch?  Can I put it into patch tracker?

Regards,
Shawn

>  arch/arm/kernel/smp_scu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> index 79ed5e7..5b6d536 100644
> --- a/arch/arm/kernel/smp_scu.c
> +++ b/arch/arm/kernel/smp_scu.c
> @@ -33,7 +33,7 @@ unsigned int __init scu_get_core_count(void __iomem *scu_base)
>  /*
>   * Enable the SCU
>   */
> -void __init scu_enable(void __iomem *scu_base)
> +void scu_enable(void __iomem *scu_base)
>  {
>  	u32 scu_ctrl;
>  
> -- 
> 1.7.4.1
