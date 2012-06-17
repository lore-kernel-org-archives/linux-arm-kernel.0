From: marex@denx.de (Marek Vasut)
Date: Sun, 17 Jun 2012 16:06:19 +0200
Subject: [PATCH 2/2] ARM: mach-mxs: Remove board entries in dt_board_compat
In-Reply-To: <1339941856-2836-2-git-send-email-festevam@gmail.com>
References: <1339941856-2836-1-git-send-email-festevam@gmail.com>
 <1339941856-2836-2-git-send-email-festevam@gmail.com>
Message-ID: <201206171606.19868.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need for adding board related entries into dt_board_compat.
> 
> Leave only the SoC entry.
> 
> This way we do not need to patch a C file when adding dt support for a new
> board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mxs/mach-mxs.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 8cac94b..0f36b22 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -91,13 +91,11 @@ static void __init mxs_machine_init(void)
>  }
> 
>  static const char *imx23_dt_compat[] __initdata = {
> -	"fsl,imx23-evk",
>  	"fsl,imx23",
>  	NULL,
>  };
> 
>  static const char *imx28_dt_compat[] __initdata = {
> -	"fsl,imx28-evk",

Don't you need this one as there's some hook?

>  	"fsl,imx28",
>  	NULL,
>  };

Best regards,
Marek Vasut
