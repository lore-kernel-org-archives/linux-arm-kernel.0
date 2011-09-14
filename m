From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Sep 2011 22:06:06 +0900
Subject: [PATCH V4 5/6] ARM: S5P6440: Add LCD-LTE480 and enable Framebuffer
	support
In-Reply-To: <1315591301-17166-6-git-send-email-ajaykumar.rs@samsung.com>
References: <1315591301-17166-1-git-send-email-ajaykumar.rs@samsung.com>
	<1315591301-17166-6-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <008701cc72df$108e5aa0$31ab0fe0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ajay Kumar wrote:
> 
> This patch:
> 	-- Adds platform device support for LCD-LTE480.
> 	-- Adds platform data for FB with win_mode and default_bpp.
> 	-- Enables FB device support and platform-lcd support.
> 	-- Adds SPCON settings for LCD.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  arch/arm/mach-s5p64x0/Kconfig                  |    2 +
>  arch/arm/mach-s5p64x0/include/mach/regs-gpio.h |    4 +
>  arch/arm/mach-s5p64x0/mach-smdk6440.c          |   75
> ++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 0 deletions(-)
> 

(snip)

> +#include <plat/regs-fb.h>

Should be <plat/regs-fb-v4.h>?

(snip)

> +/* Frame Buffer */
> +static struct s3c_fb_pd_win smdk6440_fb_win0 = {
> +	.win_mode = {
> +		.left_margin	= 8,
> +		.right_margin	= 13,
> +		.upper_margin	= 7,
> +		.lower_margin	= 5,
> +		.hsync_len	= 3,
> +		.vsync_len	= 1,
> +		.xres		= 800,
> +		.yres		= 480,
> +		.refresh	= 60,

if its value is 60, we don't need .refresh here.

(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
