From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 03 Jun 2013 20:45:26 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAxLzNdIGxlZHM6IGxlZHMtbWMxMzc4MzogUHJlcGFy?=
 =?UTF-8?B?ZSBkcml2ZXIgdG8gc3VwcG9ydCBNQzEzODkyIExFRHM=?=
In-Reply-To: <51ACC5CC.3000700@epfl.ch>
References: <1370273916-29852-1-git-send-email-shc_work@mail.ru>
 <51ACC5CC.3000700@epfl.ch>
Message-ID: <1370277926.852575788@f77.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi
> 
> > @@ -341,51 +362,55 @@ static int mc13783_led_probe(struct platform_device *pdev)
> >
> >   err_register:
> >   	for (i = i - 1; i >= 0; i--) {
> > -		led_classdev_unregister(&led[i].cdev);
> >   		cancel_work_sync(&led[i].work);
> > +		led_classdev_unregister(&led[i].cdev);
> >   	}
> >
> >   	return ret;
> >   }
> >
> > +static int mc13xxx_led_remove(struct platform_device *pdev)
> (..)
> >
> >   	for (i = 0; i < pdata->num_leds; i++) {
> > -		led_classdev_unregister(&led[i].cdev);
> >   		cancel_work_sync(&led[i].work);
> > +		led_classdev_unregister(&led[i].cdev);
> >   	}
> >
> 
> 
> Why changing the order ?

Now I realize that was a mistake.
Thanks.

---
