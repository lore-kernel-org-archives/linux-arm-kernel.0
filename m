From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 14:53:41 +0100
Subject: [PATCH 12/17] ARM: pxa/raumfeld: add audio related functions
In-Reply-To: <20091125130723.GA14045@rakim.wolfsonmicro.main>
References: <20091125122857.GJ29442@buzzloop.caiaq.de>
	<20091125130723.GA14045@rakim.wolfsonmicro.main>
Message-ID: <20091125135341.GE14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 01:07:23PM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 01:28:57PM +0100, Daniel Mack wrote:
> > Well, that's not really a regulator but just a GPIO that drives a FET.
> > Doesn't using the regulator framework seem a little overdone?
> 
> No, the main goal here is to make sure the CODEC driver knows what's
> going on with its power.  In your system it is a trivial GPIO based
> regulator that's doing the power control but other systems might have
> something different.  Looking at it from the other angle, nothing about
> powering on and off the CODEC ought to be board specific.

Ok, just to make sure I get you right: the idea would be to add a simple
regulator and label it in a way so that the codec driver will be able
to take control? And then claim that regulator from cs4270.c?

I guess "reg-fixed-voltage" would be the appropriate driver?

> > The idea was to only let the board support file know about GPIO
> > definitions, so the audio part doesn't need to know about the details.
> 
> The audio driver is already entirely board specific, knowing about the
> GPIOs isn't going to make any odds here.  At the minute reading the
> code it looks like part of the audio driver has randomly been lifted out
> into a separate file for no particular reason.

Ok, agreed. I moved it.

Thanks,
Daniel
