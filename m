From: torbenh@gmx.de (torbenh)
Date: Sat, 30 Apr 2011 16:27:02 +0200
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110429132613.GL5126@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110429103723.GF5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291252080.3005@ionos>
	<20110429110610.GJ5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291344020.3005@ionos>
	<20110429132613.GL5126@n2100.arm.linux.org.uk>
Message-ID: <20110430142702.GH13755@siel.b>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 02:26:13PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2011 at 02:13:06PM +0200, Thomas Gleixner wrote:
> > This are all well defined semantical problems and should be solved in
> > common code rather than having different buggy implementations in each
> > SoC clock "framework".
> 
> Why are you associating functional elements in drivers/clk with the
> SoC clock framework?

i think i pretty much understand what thomas is after. but i have
problems understanding, what you want here.

until this point, it looks like you only want the driver/clk to
model the clock endpoints inside the devices. A device itself shouldnt
be caring for clock parents or anything. its only concern is that a
clock pin is fed with the right frequency, or off...

> 
> I think that's the root cause of this misunderstanding, and until you
> start realising that these building blocks are not part of the SoC
> implementation, we're going to continue arguing about this.

what you say now, pretty much sounds like what thomas wants.
these building blocks would be objects derived from the clock baseclass,
which thomas is trying to define. he doesnt seem to be concerned about
the second more special layer yet.

i am quite puzzled, what exactly your fighting over :S


> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
torben Hohn
