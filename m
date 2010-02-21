From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 21 Feb 2010 02:28:07 -0800
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <201002211210.12306.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002211105.30079.anarsoul@gmail.com>
	<20100221094151.GC18298@core.coreip.homeip.net>
	<201002211210.12306.anarsoul@gmail.com>
Message-ID: <20100221102807.GE18298@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 21, 2010 at 12:10:08PM +0200, Vasily Khoruzhick wrote:
> ? ????????? ?? 21 ??????? 2010 11:41:51 ????? Dmitry Torokhov ???????:
> > > Timer is used to avoid reporting input events in interrupt context
> > > (select callback is called from s3c_adc_try and from s3c_adc_irq),
> > ??? This is quite a novel concept for me...
> 
> I think so, as I don't see any other reasons to use timer :)
> 
> > > Anyway, driver
> > > doesn't work for me with this patch (it works as mouse, but it doesn't as
> > > touchscreen through tslib)
> > 
> > Hmm, does evtest utility report all expected events?
> 
> evtest shows that driver starts event flood on first touch, i.e. it doesn't 
> stop to emit event when stylus is up.
> 

While flooding does it report BTN_TOUCH as up or down? I might have messed
s3c24xx_ts_check_pen_down()...

-- 
Dmitry
