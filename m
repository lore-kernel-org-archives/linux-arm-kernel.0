From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Sep 2010 16:08:44 +0900
Subject: [PATCHv2 2/7] ARM: S5PC110: fb setup for Goni - remove pixel clock
In-Reply-To: <1284987337-15365-3-git-send-email-m.szyprowski@samsung.com>
References: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
	<1284987337-15365-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <005901cb5edb$ffd2e090$ff78a1b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Since commit 67a38950f0917aecfe1a3e46720d8bbb0020 there is no need
> to set pixel clock for the s3c-fb driver's window information.
> The correct pixel clock value can be automatically calculated from
> the other screen parameters. This patch removes the redundant pixel clock
> parameter.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/mach-goni.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index 4bd5582..b0ae208 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -88,7 +88,6 @@ static struct s3c2410_uartcfg goni_uartcfgs[] __initdata
= {
>  /* Frame Buffer */
>  static struct s3c_fb_pd_win goni_fb_win0 = {
>  	.win_mode = {
> -		.pixclock = 1000000000000ULL /
> ((16+16+2+480)*(28+3+2+800)*55),
>  		.left_margin	= 16,
>  		.right_margin	= 16,
>  		.upper_margin	= 2,
> --

Ok..will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
