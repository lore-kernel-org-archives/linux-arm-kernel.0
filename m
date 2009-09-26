From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 26 Sep 2009 18:55:36 +0400
Subject: something wrong in drivers/power
In-Reply-To: <20090926095555.GG1331@ucw.cz>
References: <20090926095555.GG1331@ucw.cz>
Message-ID: <20090926145536.GA8445@doriath.ww600.siemens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 26, 2009 at 11:55:55AM +0200, Pavel Machek wrote:
> 
> Tosa battery driver seems to be confused about its own identity.

NAK. Please see the drivers/input/touchscree/wm97xx-core.c

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff -ur power.ofic/tosa_battery.c power/tosa_battery.c
> --- linux/drivers/power.ofic/tosa_battery.c	2009-09-06 08:56:36.000000000 +0200
> +++ linux/drivers/power/tosa_battery.c	2009-09-15 15:14:08.000000000 +0200
> @@ -459,7 +459,7 @@
>  }
>  
>  static struct platform_driver tosa_bat_driver = {
> -	.driver.name	= "wm97xx-battery",
> +	.driver.name	= "tosa-battery",
>  	.driver.owner	= THIS_MODULE,
>  	.probe		= tosa_bat_probe,
>  	.remove		= __devexit_p(tosa_bat_remove),
> @@ -483,4 +483,4 @@
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Dmitry Baryshkov");
>  MODULE_DESCRIPTION("Tosa battery driver");
> -MODULE_ALIAS("platform:wm97xx-battery");
> +MODULE_ALIAS("platform:tosa-battery");
> 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
With best wishes
Dmitry
