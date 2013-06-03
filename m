From: philippe.retornaz@epfl.ch (=?ISO-8859-1?Q?Philippe_R=E9tornaz?=)
Date: Mon, 03 Jun 2013 18:35:24 +0200
Subject: [PATCH 1/3] leds: leds-mc13783: Prepare driver to support MC13892
 LEDs
In-Reply-To: <1370273916-29852-1-git-send-email-shc_work@mail.ru>
References: <1370273916-29852-1-git-send-email-shc_work@mail.ru>
Message-ID: <51ACC5CC.3000700@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> @@ -341,51 +362,55 @@ static int mc13783_led_probe(struct platform_device *pdev)
>
>   err_register:
>   	for (i = i - 1; i >= 0; i--) {
> -		led_classdev_unregister(&led[i].cdev);
>   		cancel_work_sync(&led[i].work);
> +		led_classdev_unregister(&led[i].cdev);
>   	}
>
>   	return ret;
>   }
>
> +static int mc13xxx_led_remove(struct platform_device *pdev)
(..)
>
>   	for (i = 0; i < pdata->num_leds; i++) {
> -		led_classdev_unregister(&led[i].cdev);
>   		cancel_work_sync(&led[i].work);
> +		led_classdev_unregister(&led[i].cdev);
>   	}
>


Why changing the order ?

Thanks,

Philippe
