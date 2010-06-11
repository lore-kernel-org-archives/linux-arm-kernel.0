From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 11 Jun 2010 12:08:01 +0200
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <20100611095839.GC10894@pengutronix.de>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<201006111557.12249.jeremy.kerr@canonical.com>
	<19473.61547.684572.647641@ipc1.ka-ro>
	<201006111718.47426.jeremy.kerr@canonical.com>
	<19474.172.742782.972629@ipc1.ka-ro>
	<20100611095839.GC10894@pengutronix.de>
Message-ID: <19474.2817.333749.485028@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > > > Using a mutex in clk_enable()/clk_disable() is a bad idea, since that
> > > > makes it impossible to call those functions in interrupt context.
> IMHO if a device generates an irq its clock should already be on.  This
> way you don't need to enable or disable a clock in irq context.
>  
You may want to disable a clock in the IRQ handler. The VPU driver in
the Freescale BSP for i.MX51 does exactly this.
Anyway I don't see any reason for using a mutex here instead of
spin_lock_irq_save() as all other implementations do.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
