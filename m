From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 18 Feb 2011 17:15:09 +0100 (CET)
Subject: [PATCH 1/2] PRUSS UIO driver support
In-Reply-To: <201102181644.17634.arnd@arndb.de>
References: <1298041530-26855-1-git-send-email-pratheesh@ti.com>
	<1298041530-26855-2-git-send-email-pratheesh@ti.com>
	<201102181644.17634.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1102181713480.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Feb 2011, Arnd Bergmann wrote:
> On Friday 18 February 2011, Pratheesh Gangadhar wrote:
> > Signed-off-by: Pratheesh Gangadhar <pratheesh@ti.com>
> > +static irqreturn_t pruss_handler(int irq, struct uio_info *dev_info)
> > +{
> > +	return IRQ_HANDLED;
> > +}
> 
> An empty interrupt handler is rather pointless. I guess you really
> notify user space when the interrupt handler gets called, as this
> is the main point of a UIO driver as far as I understand it.

The UIO core code does this for you when the driver handler returns
IRQ_HANDLED, but the empty handler raises a different questions:

Is the interrupt edge triggerd or how do you avoid an irq storm here?
Usually UIO drivers are requested to mask the interrupt in the device
itself.

Thanks,

	tglx
