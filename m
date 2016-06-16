From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Jun 2016 16:41:35 +0200
Subject: [PATCH 44/48] clocksource: atmel-pit: allow unselecting ATMEL_PIT
In-Reply-To: <alpine.DEB.2.11.1606132114190.5839@nanos>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-45-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1606111143330.5839@nanos>
 <20160611105351.GH19050@piout.net>
 <20160613210416.4fef01d2@bbrezillon>
 <alpine.DEB.2.11.1606132114190.5839@nanos>
Message-ID: <20160616164135.7d810a7b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, 13 Jun 2016 21:14:47 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 13 Jun 2016, Boris Brezillon wrote:
> > On Sat, 11 Jun 2016 12:53:51 +0200
> > Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> >   
> > > On 11/06/2016 at 11:43:54 +0200, Thomas Gleixner wrote :  
> > > > On Sat, 11 Jun 2016, Alexandre Belloni wrote:
> > > >     
> > > > > With the new TCB clocksource driver, atmel platforms are now able to boot
> > > > > without the PIT driver. Allow unselecting it.    
> > > > 
> > > > Yay! Thanks for doing this!
> > > >     
> > > 
> > > Sure! Can you still check the request_irq/free_irq in
> > > timer-atmel-tcbclksrc? I'm not sure whether this can work reliably or
> > > only because we are before SYSTEM_STATE=RUNNING.
> > > In the latter case, I have another way of doing that.
> > >   
> > 
> > Sorry to put it back on the table, but shouldn't we consider adding
> > these irq_disable/enable_action() helpers?  
> 
> I fear that's the only reliable way to do it.

Alexandre told me you had a better implementation (or idea, I don't
remember) than what was proposed here [1].
Do you plan to submit something, or should we work on it?

Regards,

Boris

[1]https://lkml.org/lkml/2015/8/3/330

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
