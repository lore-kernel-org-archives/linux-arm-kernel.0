From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 21 Feb 2010 01:41:51 -0800
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <201002211105.30079.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002191202.16384.anarsoul@gmail.com>
	<20100221073512.GA18298@core.coreip.homeip.net>
	<201002211105.30079.anarsoul@gmail.com>
Message-ID: <20100221094151.GC18298@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 21, 2010 at 11:05:26AM +0200, Vasily Khoruzhick wrote:
> ? ????????? ?? 21 ??????? 2010 09:35:13 ????? Dmitry Torokhov ???????:
> 
> > Applied, thank you Vasily.
> > 
> > One more thing though - why do we need that timer to report input events
> > and reschedule ADC conversions? It looks like it is not really needed.
> > Could you please give a try to the patch below?
> > 
> > Thanks!
> 
> Timer is used to avoid reporting input events in interrupt context (select 
> callback is called from s3c_adc_try and from s3c_adc_irq),

??? This is quite a novel concept for me...

> Is it safe to call 
> input_report_abs/input_report_key from interrupt context?

Yes.

> Anyway, driver 
> doesn't work for me with this patch (it works as mouse, but it doesn't as 
> touchscreen through tslib)

Hmm, does evtest utility report all expected events?

-- 
Dmitry
