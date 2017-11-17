From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 17 Nov 2017 12:25:47 -0800
Subject: [PATCH 02/10] Input: omap4-keypad: Fix platform_get_irq's error
 checking
In-Reply-To: <1510946132-13554-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1510946132-13554-3-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20171117202547.beetoal3wjaie6hp@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 12:45:24AM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/input/keyboard/omap4-keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index 940d38b..8a4b161 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -251,7 +251,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (!irq) {
> +	if (irq < 0) {
>  		dev_err(&pdev->dev, "no keyboard irq assigned\n");
>  		return -EINVAL;

return irq

>  	}
> -- 
> 2.7.4
> 

-- 
Dmitry
