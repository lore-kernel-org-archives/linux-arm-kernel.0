From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Tue, 30 May 2017 17:18:53 +0200
Subject: [PATCH 1/2] gpio: mvebu: fix blink counter register selection
In-Reply-To: <20170530122848.2803-1-richard.genoud@gmail.com>
References: <20170530122848.2803-1-richard.genoud@gmail.com>
Message-ID: <20170530171853.64630ce6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard

On Tue, 30 May 2017 14:28:47 +0200
Richard Genoud <richard.genoud@gmail.com> wrote:

> The blink counter A was always selected because 0 was forced in the
> blink select counter register.
> The variable 'set' was obviously there to be used as the register
> value, selecting the B counter when id==1 and A counter when id==0.
> 
> Tested on clearfog-pro (Marvell 88F6828)

As stated in the other thread, testing on clearfog-pro is likely bogus,
still the fix is correct.

Reviewed-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Thanks
Ralph

> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/gpio/gpio-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 19a92efabbef..cdef2c78cb3b 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -747,7 +747,7 @@ static int mvebu_pwm_probe(struct platform_device
> *pdev, set = U32_MAX;
>  	else
>  		return -EINVAL;
> -	writel_relaxed(0,
> mvebu_gpioreg_blink_counter_select(mvchip));
> +	writel_relaxed(set,
> mvebu_gpioreg_blink_counter_select(mvchip)); 
>  	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm),
> GFP_KERNEL); if (!mvpwm)
