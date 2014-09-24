From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 24 Sep 2014 19:29:05 +0800
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <2923729.dtX0WmHSV0@wuerfel>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140924022736.GA5307@peterchendt> <2990737.4KzKXPZhaB@wuerfel>
 <2923729.dtX0WmHSV0@wuerfel>
Message-ID: <20140924112902.GA23331@peterchendt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 10:30:41AM +0200, Arnd Bergmann wrote:
> On Wednesday 24 September 2014 09:44:19 Arnd Bergmann wrote:
> > 
> > We can also gradually move in some of the other glue drivers into
> > the main driver if the differences are small enough.
> > 
> 
> FWIW, I've just looked at the other glue drivers that already
> exist:
> 
> - zevio can just get merged into the common driver, all that seems
>   to be needed for that is the additional compatible string, and
>   keying off the ci_default_zevio_platdata on the .data field of
>   the of_device_id table.
> 
> - msm has a custom notifier, which justifies leaving it in a separate
>   driver, but it's also small enough that it wouldn't hurt to have
>   that merged into the main driver too.
> 
> - imx requires a lot of other things, in particular the dependency
>   on the usbmisc driver means we don't want to have that in the
>   core anyway, so we can't really merge that in.
> 
> - the proposed ar933x driver again looks almost trivial, so no reason
>   for a separate glue driver for that.
> 
> 	Arnd

Thanks, Arnd.

So, it is IP CORE LIB (you suggest) vs IP CORE Platform Driver
(dwc3, musb, chipidea) you are talking about, right? Except for
creating another platform driver as well as related DT node (optional),
are there any advantages compared to current IP core driver structure?

In this thread, we are talking about creating common platform driver for glue
layer, its design purpose (adapt it for as many as platforms) should be the
same, no matter the IP core part is a LIB or platform driver, am I missing
something?

-- 
Best Regards,
Peter Chen
