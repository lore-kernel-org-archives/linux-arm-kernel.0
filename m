From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 15 Feb 2011 16:59:28 +0300
Subject: [PATCH] i2c-pxa: fix unbinding/rebinding of the device
In-Reply-To: <20110108161828.GC8237@pengutronix.de>
References: <20110106124028.GX25121@pengutronix.de>
	<1294502804-6580-1-git-send-email-dbaryshkov@gmail.com>
	<20110108161828.GC8237@pengutronix.de>
Message-ID: <AANLkTimO1KFNm5xZ+2qJoGQq-ndVg0ER3KKwf0RYYOLK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, all

2011/1/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Sat, Jan 08, 2011 at 07:06:44PM +0300, Dmitry Eremin-Solenikov wrote:
>> When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
>> callback was not called because it was discarded when linking the
>> kernel. ?Because of that the resources allocated in probe were not
>> freed and so a clean unbind/rebind was impossible.
>>
>> Fix that by moving the remove callback to .devexit.text.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

I see this patch is still not pushed to neither linus nor linux-next.
Should I put it into rmk's patch system? Or will it find it's way to main kernel
via other paths?

>
> Thanks
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>



-- 
With best wishes
Dmitry
