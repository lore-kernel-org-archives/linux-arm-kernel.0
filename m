From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 22:36:19 +0900
Subject: [PATCH 12/15] ARM: SMDKC100: fix frame buffer definitions
In-Reply-To: <1273817946-29404-13-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
	<1273817946-29404-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <004c01caf5c5$f0eae9d0$d2c0bd70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Fix incorrectly defined pixel clock value for the default framebuffer
> window.

It is better that separate this patch from c100 clean up patch set.
As you know, this patch is unrelated to that.

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/mach-smdkc100.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-
> s5pc100/mach-smdkc100.c
> index 9155564..7df8ed0 100644
> --- a/arch/arm/mach-s5pc100/mach-smdkc100.c
> +++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
> @@ -118,8 +118,7 @@ static struct platform_device smdkc100_lcd_powerdev = {
>  static struct s3c_fb_pd_win smdkc100_fb_win0 = {
>  	/* this is to ensure we use win0 */
>  	.win_mode	= {
> -		.refresh	= 70,
> -		.pixclock	= (8+13+3+800)*(7+5+1+480),
> +		.pixclock = 1000000000000ULL / ((8+13+3+800)*(7+5+1+480)*80),

As I've commented, how about moving to related LCD driver than hard coding
here.

>  		.left_margin	= 8,
>  		.right_margin	= 13,
>  		.upper_margin	= 7,
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
