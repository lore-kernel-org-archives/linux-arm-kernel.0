From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 11 Aug 2011 16:50:59 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix Section Mismatch in PWM backlight
	support
In-Reply-To: <1312878286-6300-1-git-send-email-myungjoo.ham@samsung.com>
References: <1312878286-6300-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <015b01cc57fb$6a7f7ed0$3f7e7c70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/dev-backlight.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-backlight.c
b/arch/arm/plat-samsung/dev-
> backlight.c
> index 3cedd4c..6955704 100644
> --- a/arch/arm/plat-samsung/dev-backlight.c
> +++ b/arch/arm/plat-samsung/dev-backlight.c
> @@ -76,7 +76,7 @@ static struct platform_device samsung_dfl_bl_device
> __initdata = {
>   * @gpio_info:	structure containing GPIO info for PWM timer
>   * @bl_data:	structure containing Backlight control data
>   */
> -void samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
> +void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
>  	struct platform_pwm_backlight_data *bl_data)
>  {
>  	int ret = 0;
> --

Hi MyungJoo,

Same patch has been submitted like following.

http://article.gmane.org/gmane.linux.kernel.samsung-soc/6060

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
