From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 Jan 2010 15:49:31 +0100
Subject: disable_irq() causes hang on AT91RM9200 targets?
In-Reply-To: <4B61C645.4030104@billgatliff.com>
References: <4B61C2C7.2000405@billgatliff.com>
	<4B61C645.4030104@billgatliff.com>
Message-ID: <20100129144931.GB27577@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 28, 2010 at 11:15:49AM -0600, Bill Gatliff wrote:
> Bill Gatliff wrote:
> > Guys:
> >
> >
> > Has anyone noticed that with 2.6.33-rc5 (at least) on AT91RM9200,
> > disable_irq() seems to cause a lockup when the interrupt number is a
> > GPIO line?  I'm calling disable_irq() from an interrupt handler on the
> > same GPIO line.
> >
> > I just saw this happen, and it seems to be repeatable.  Just wondering
> > if this is a known issue before I start digging into it...
> >   
> 
> Heh, disable_irq_nosync().  D'oh!  :)
Can make this a bit more verbose:

 [ ] After switching from disable_irq to disable_irq_nosync it magically
     works.
 [ ] Of course I know not to use disable_irq in irq context.  I meant it
     causes a lockup when I use *disable_irq_nosync* in irq context.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
