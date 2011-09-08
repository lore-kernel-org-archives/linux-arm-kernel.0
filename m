From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Sep 2011 09:55:02 +0100
Subject: [PATCH 3/4] mach-integrator: modernize clock event registration
In-Reply-To: <alpine.LFD.2.02.1109071202000.2723@ionos>
References: <1315384260-27404-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.02.1109071202000.2723@ionos>
Message-ID: <20110908085502.GB14953@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 12:02:52PM +0200, Thomas Gleixner wrote:
> On Wed, 7 Sep 2011, Linus Walleij wrote:
> 
> > From: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Drop the reload value for the timer - the timekeeping code
> > will call the .set_next_event to set this anyway.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> > 
> > Drop mult, shift and delta calculations and let the
> > clockevent core scale this as appropriate.
> > 
> > Set the minimum interval to 1 rather than 15 (0xf), there
> > is nothing in the data sheets I have indicating that 15
> > should be some minimum value.
> > 
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

I mentioned to Thomas that which I've underlined above yesterday after I
received Thomas' ack.  I was expecting Thomas to reply about this, but
that obviously hasn't happened, so now that it's appeared in the patch
system, it's become my problem to deal with.

My understanding is that periodic timers are not setup by the generic
clock event code, and so we do need to keep the 'timer_reload' stuff
around.  Note that patch 2 deletes the register write for this too,
so you actually have one logical change split across patch 2 and 3.
