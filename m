From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Jul 2015 02:48:03 -0700
Subject: [PATCH 1/2] input: touchscreen: pixcir_i2c_ts: Add support for
 optional wakeup interrupt
In-Reply-To: <20150720063323.GC13092@dtor-ws>
References: <1437115241-17859-1-git-send-email-vigneshr@ti.com>
 <1437115241-17859-2-git-send-email-vigneshr@ti.com>
 <20150717215122.GC39282@dtor-ws> <55AC7DA1.9050002@ti.com>
 <20150720060506.GV17550@atomide.com>
 <20150720063323.GC13092@dtor-ws>
Message-ID: <20150720094803.GY17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [150719 23:36]:
> On Sun, Jul 19, 2015 at 11:05:07PM -0700, Tony Lindgren wrote:
> > * Vignesh R <vigneshr@ti.com> [150719 21:51]:
> > > On 7/18/2015 3:21 AM, Dmitry Torokhov wrote:
> > > > 
> > > > I wonder if driver core should be responsible for clearing wake irq and
> > > > also for clearing wakeup flag.
> > > > 
> > > 
> > > AFAICU, wakeup flag is deleted when struct device is deleted, hence,
> > > device_init_wakeup() call may not be required in .remove(). But,
> > > dev_pm_clear_wake_irq() can be moved to driver core.
> > 
> > Currently the lifecycle of struct wakeup_source is not necessarily
> > the same as the lifecycle struct device. I believe net and usb drivers
> > at least allocate it dynamically.
> 
> I am not sure if I follow. I was wondering if we should clear the wakeup
> IRQ setting on the driver unbinding. It does not mean that we'd be
> deleting wakeup_source, just that we'll clear wakeup irq setting from
> it.

Yes you're right we can do that. I was mostly commenting on why we
currently can't automate things further with devm.

Regards,

Tony
