From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 24 Sep 2011 01:16:59 +0800
Subject: [PATCH 2/4] ARM i.MX tzic: add handle_irq function
In-Reply-To: <1316522956-28530-3-git-send-email-s.hauer@pengutronix.de>
References: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
	<1316522956-28530-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110923171658.GB15511@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 02:49:14PM +0200, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/common.h |    4 ++++
>  arch/arm/plat-mxc/tzic.c                |   24 +++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 8de0d0c..2e8802b 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -74,6 +74,7 @@ extern int mx53_revision(void);
>  extern int mx53_display_revision(void);
>  
>  void avic_handle_irq(struct pt_regs *);
> +void tzic_handle_irq(struct pt_regs *);
>  
>  #define mx1_handle_irq avic_handle_irq
>  #define mx21_handle_irq avic_handle_irq
> @@ -81,5 +82,8 @@ void avic_handle_irq(struct pt_regs *);
>  #define mx27_handle_irq avic_handle_irq
>  #define mx31_handle_irq avic_handle_irq
>  #define mx35_handle_irq avic_handle_irq
> +#define mx50_handle_irq tzic_handle_irq
> +#define mx51_handle_irq tzic_handle_irq
> +#define mx53_handle_irq tzic_handle_irq
>  
Can we start forcing the consistent file/function naming between mx*
and imx*?  I bet imx* will win :)

-- 
Regards,
Shawn
