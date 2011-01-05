From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 5 Jan 2011 14:17:44 +0300
Subject: [PATCH 6/6] Fix eseries compilation if w100fb is not compiled in
	kernel
In-Reply-To: <20110105105404.GP25121@pengutronix.de>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
	<1294193110-23958-6-git-send-email-dbaryshkov@gmail.com>
	<20110105082748.GM25121@pengutronix.de>
	<20110105105404.GP25121@pengutronix.de>
Message-ID: <AANLkTimapus2fz=+SrQ9=a51FqgeaaPjPpjZzwPUGDvB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/5 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello again,
>
> On Wed, Jan 05, 2011 at 09:27:49AM +0100, Uwe Kleine-K?nig wrote:
>> Hello Dmitry,
>>
>> On Wed, Jan 05, 2011 at 05:05:10AM +0300, Dmitry Eremin-Solenikov wrote:
>> > e800_tg_change depends on w100fb_gpio_read/write API which is only present
>> > if w100fb is compiled in kernel.
>> >
>> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> > Cc: Ian Molton <ian@mnementh.co.uk>
>> > ---
>> > ?arch/arm/mach-pxa/eseries.c | ? ?2 ++
>> > ?1 files changed, 2 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
>> > index b25690c..ed2c157 100644
>> > --- a/arch/arm/mach-pxa/eseries.c
>> > +++ b/arch/arm/mach-pxa/eseries.c
>> > @@ -829,6 +829,7 @@ static struct w100_mem_info e800_w100_mem_info = {
>> >
>> > ?static void e800_tg_change(struct w100fb_par *par)
>> > ?{
>> > +#ifdef FB_W100
>> CONFIG_FB_W100?
>>
>> > ? ? unsigned long tmp;
>> >
>> > ? ? tmp = w100fb_gpio_read(W100_GPIO_PORT_A);
>> > @@ -837,6 +838,7 @@ static void e800_tg_change(struct w100fb_par *par)
>> > ? ? else
>> > ? ? ? ? ? ? tmp &= ~0x100;
>> > ? ? w100fb_gpio_write(W100_GPIO_PORT_A, tmp);
>> > +#endif
>> What happens if FB_W100=m? ?The code isn't compiled in, would it still
>> be necessary?
> did you see commit a74b74a5555c741ed3df896096e33b853995631e?

Missed it. Then this patch can be safely dropped :)

>
> http://git.kernel.org/linus/a74b74a5555c741ed3df896096e33b853995631e
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>



-- 
With best wishes
Dmitry
