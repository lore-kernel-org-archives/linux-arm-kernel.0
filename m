From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 11 Jun 2010 18:50:30 +0800
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <19474.2817.333749.485028@ipc1.ka-ro>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<20100611095839.GC10894@pengutronix.de>
	<19474.2817.333749.485028@ipc1.ka-ro>
Message-ID: <201006111850.32528.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

> You may want to disable a clock in the IRQ handler. The VPU driver in
> the Freescale BSP for i.MX51 does exactly this.

Is this something we can defer to a sleepable context?

> Anyway I don't see any reason for using a mutex here instead of
> spin_lock_irq_save() as all other implementations do.

Just that enable/disable may take an arbitrarily long time to complete. Sounds 
like that hasn't been a problem in the past though.

Cheers,


Jeremy
