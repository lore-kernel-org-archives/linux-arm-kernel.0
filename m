From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 Feb 2012 14:42:15 +0800
Subject: [PATCH] ARM i.MX5/6: Add dt support for generic boards
In-Reply-To: <1329476820-27066-1-git-send-email-s.hauer@pengutronix.de>
References: <1329476820-27066-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120220064213.GB19668@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 12:07:00PM +0100, Sascha Hauer wrote:
> Apart from the iomux setup which may not be needed on custom
> boards the kernel starts fine using the devicetree, so add
> generic boards to the dt_compat entries.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/imx51-dt.c   |    1 +
>  arch/arm/mach-imx/imx53-dt.c   |    1 +
>  arch/arm/mach-imx/mach-imx6q.c |    1 +
>  3 files changed, 3 insertions(+), 0 deletions(-)
> 
I guess the point that the patch is trying to make is that we do not
need to touch these files whenever we add a new board booting with
device tree, if the board does not need any special handling there
with its compatible string.

But we may still need a specific compatible string for the board in its
.dts file rather than just specific common like "fsl,imx6q".  That
said, Documentation/devicetree/bindings/arm/fsl.txt needs an update
anyway whenever a new board support is added.

Also, isn't it a good thing to have the dt_compat list explicitly show
all the boards that the dt file supports?

Regards,
Shawn

> diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
> index e6bad17..b0d830f 100644
> --- a/arch/arm/mach-imx/imx51-dt.c
> +++ b/arch/arm/mach-imx/imx51-dt.c
> @@ -104,6 +104,7 @@ static struct sys_timer imx51_timer = {
>  
>  static const char *imx51_dt_board_compat[] __initdata = {
>  	"fsl,imx51-babbage",
> +	"fsl,imx51",
>  	NULL
>  };
>  
> diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
> index 05ebb3e..d75a267 100644
> --- a/arch/arm/mach-imx/imx53-dt.c
> +++ b/arch/arm/mach-imx/imx53-dt.c
> @@ -114,6 +114,7 @@ static const char *imx53_dt_board_compat[] __initdata = {
>  	"fsl,imx53-evk",
>  	"fsl,imx53-qsb",
>  	"fsl,imx53-smd",
> +	"fsl,imx53",
>  	NULL
>  };
>  
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index c257281..f3adf2f 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -128,6 +128,7 @@ static struct sys_timer imx6q_timer = {
>  static const char *imx6q_dt_compat[] __initdata = {
>  	"fsl,imx6q-arm2",
>  	"fsl,imx6q-sabrelite",
> +	"fsl,imx6q",
>  	NULL,
>  };
>  
> -- 
> 1.7.9
> 
