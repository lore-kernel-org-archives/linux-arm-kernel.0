From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 14 Jun 2010 08:40:28 +0200
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <19477.52889.982995.407051@ipc1.ka-ro>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<201006111557.12249.jeremy.kerr@canonical.com>
	<19473.61547.684572.647641@ipc1.ka-ro>
	<201006111718.47426.jeremy.kerr@canonical.com>
	<19474.172.742782.972629@ipc1.ka-ro>
	<20100611095839.GC10894@pengutronix.de>
	<19474.2817.333749.485028@ipc1.ka-ro>
	<1276319643.1962.181.camel@pasglop>
	<19477.52889.982995.407051@ipc1.ka-ro>
Message-ID: <20100614064028.GA12159@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lothar,

On Mon, Jun 14, 2010 at 08:39:21AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Benjamin Herrenschmidt writes:
> > On Fri, 2010-06-11 at 12:08 +0200, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > > > > > Using a mutex in clk_enable()/clk_disable() is a bad idea, since that
> > > > > > > makes it impossible to call those functions in interrupt context.
> > > > IMHO if a device generates an irq its clock should already be on.  This
> > > > way you don't need to enable or disable a clock in irq context.
> > > >  
> > > You may want to disable a clock in the IRQ handler. The VPU driver in
> > > the Freescale BSP for i.MX51 does exactly this.
> > > Anyway I don't see any reason for using a mutex here instead of
> > > spin_lock_irq_save() as all other implementations do.
> > 
> > Because you suddenly make it impossible to sleep inside enable/disable
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ???
> All implementations so far use spin_lock_irq_save()!
> 
> How would you be able to sleep with a mutex held?
> If you hold a lock you must not sleep, no matter what sort of lock it
> is.
That's wrong.  With a mutex hold you may sleep.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
