From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 9 Nov 2011 16:25:04 +0530
Subject: [PATCH 4/6] spi/pl022: skip default configuration before
 suspending
In-Reply-To: <1320835154-31303-1-git-send-email-linus.walleij@stericsson.com>
References: <1320835154-31303-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4EBA5C08.1040709@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/2011 4:09 PM, Linus WALLEIJ wrote:
> From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> 
> The loading of the default configuration before suspending has
> been in the driver since its inception, but it is not really
> needed. Especially so since we take to all the trouble of
> enabling and disabling power and clock just to do this. Let's
> scrap this now.
> 
> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/spi/spi-pl022.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index fa3eaae..bffad2a 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2314,12 +2314,7 @@ static int pl022_suspend(struct device *dev)
>  		return status;
>  	}
>  
> -	amba_vcore_enable(pl022->adev);
> -	amba_pclk_enable(pl022->adev);
> -	load_ssp_default_config(pl022);
> -	amba_pclk_disable(pl022->adev);
> -	amba_vcore_disable(pl022->adev);
> -	dev_dbg(dev, "suspended\n");
> +	dev_dbg(&adev->dev, "suspended\n");

why adev->dev instead of dev?

>  	return 0;
>  }
>  


-- 
viresh
