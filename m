From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jan 2016 09:16:06 +0000
Subject: [PATCH] mfd: asic3: remove extraneous ')'
In-Reply-To: <5507931.oM3h7nKshR@wuerfel>
References: <5507931.oM3h7nKshR@wuerfel>
Message-ID: <20160112091606.GV19803@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jan 2016, Arnd Bergmann wrote:
> A cleanup patch introduced an extra closing ')' that leads to a
> build error:
> 
> drivers/mfd/asic3.c: In function 'asic3_gpio_get':
> drivers/mfd/asic3.c:505:12: error: expected ';' before ')' token
> 
> This removes the extra character to get it to build again.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: fd5b4d01a638 ("mfd: asic3: Be sure to clamp return value")
> ---
> This came up today on linux-next. I took the liberty to adjust formatting
> of that line as well, if you prefer the original line wrapping please
> undo that part when applying.

Please ignore MFD in next, as it's not quite ready.  I've been on
vacation for 4 weeks and only returned to work yesterday.  I am
currently running MFD through AIAIAI and will fix-up any issues I
find.

> diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
> index c8d46e51faf1..4dca6bc61f5b 100644
> --- a/drivers/mfd/asic3.c
> +++ b/drivers/mfd/asic3.c
> @@ -501,8 +501,8 @@ static int asic3_gpio_get(struct gpio_chip *chip,
>  		return -EINVAL;
>  	}
>  
> -	return !!(asic3_read_register(asic, gpio_base + ASIC3_GPIO_STATUS)
> -		  & mask));
> +	return !!(asic3_read_register(asic,
> +				      gpio_base + ASIC3_GPIO_STATUS) & mask);
>  }
>  
>  static void asic3_gpio_set(struct gpio_chip *chip,
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
