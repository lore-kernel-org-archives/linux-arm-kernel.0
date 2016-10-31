From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 31 Oct 2016 12:16:12 -0600 (MDT)
Subject: [PATCH v2] irqchip/bcm2836: Prevent spurious interrupts
In-Reply-To: <8737jcs8mc.fsf@eliezer.anholt.net>
References: <20161027182038.11312-1-eric@anholt.net>
 <alpine.DEB.2.20.1610281257230.4896@nanos>
 <87bmy4qxnb.fsf@eliezer.anholt.net>
 <alpine.DEB.2.20.1610282141030.5053@nanos>
 <8737jcs8mc.fsf@eliezer.anholt.net>
Message-ID: <alpine.DEB.2.20.1610311213460.10522@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Oct 2016, Eric Anholt wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > On Fri, 28 Oct 2016, Eric Anholt wrote:
> >
> >> Thomas Gleixner <tglx@linutronix.de> writes:
> >> > This is missing a fixes tag. I have no idea when that problem was
> >> > introduced, so I have no way to decide whether this needs to be tagged
> >> > stable or not.
> >> 
> >> This code has been there since introduction of the driver, so:
> >> 
> >> Fixes: 1a15aaa998dc ("irqchip: Add bcm2836 interrupt controller for Raspberry Pi 2")
> >
> > So it want's a stable tag, right?
> 
> I'm not the author here, and I was just trying to provide an assist with
> upstreaming, so I'm not going to get too involved.  I'd say this is an
> edge case for being a stable tree candidate (it's produces a scary dmesg
> warning but no other functional problems that I know of), and I didn't
> add a fixes tag myself because of that.

A fixes tag is not the same as a stable tag, I really want to see Fixes
tags on patches which are bug fixes as it makes it simple to see the
context in which a bug was introduced.

vs. the stable tag: scary warnings tend to confuse users and cause people
to send bug reports. So in this case I'd add one.

Thanks,

	tglx
