From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Sep 2010 18:49:59 +0900
Subject: [PATCH 1/6] ARM: S5PC110: update framebuffer setup information for
	Goni
In-Reply-To: <1284103403-10696-2-git-send-email-m.szyprowski@samsung.com>
References: <1284103403-10696-1-git-send-email-m.szyprowski@samsung.com>
	<1284103403-10696-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <000401cb50cd$8b3f72a0$a1be57e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Change the default upper_margin and vsync_len to get rid of repeated last
> line on the display.
> 
How about Aquila board? Maybe same in my thinking.
And it'd better that another stuff like removing pixclock is in different
patch.

Anyway, looks ok to me...will apply.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/mach-goni.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index d9fe739..b0ae208 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -88,13 +88,12 @@ static struct s3c2410_uartcfg goni_uartcfgs[]
__initdata = {
>  /* Frame Buffer */
>  static struct s3c_fb_pd_win goni_fb_win0 = {
>  	.win_mode = {
> -		.pixclock = 1000000000000ULL /
> ((16+16+2+480)*(28+3+2+800)*55),
>  		.left_margin	= 16,
>  		.right_margin	= 16,
> -		.upper_margin	= 3,
> +		.upper_margin	= 2,
>  		.lower_margin	= 28,
>  		.hsync_len	= 2,
> -		.vsync_len	= 2,
> +		.vsync_len	= 1,
>  		.xres		= 480,
>  		.yres		= 800,
>  		.refresh	= 55,
> --
> 1.7.2.2


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
