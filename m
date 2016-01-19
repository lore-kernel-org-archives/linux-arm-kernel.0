From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Jan 2016 02:22:47 +0100
Subject: [PATCH 4.4-rt2] fix
 arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch
In-Reply-To: <569D49FC.2050500@linutronix.de>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118172522.GB12309@linutronix.de>
 <20160118184247.GQ3367@piout.net> <569D49FC.2050500@linutronix.de>
Message-ID: <20160119012247.GV3367@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/2016 at 21:24:28 +0100, Sebastian Andrzej Siewior wrote :
> > 
> > My understanding is that clockevents_exchange_device() changes the state
> > from detached to shutdown and so at that point the IRQ has never been
> > requested.
> 
> I see. So we get shutdown called twice while set_periodic was only
> called once. In that case I would suggest to have internal bookkeeping
> instead of relying on current core's behavior when it is time free the
> irq.
> 

Ok, I can do that. What should I base my patch on?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
