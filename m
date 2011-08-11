From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 11 Aug 2011 09:49:06 +0100
Subject: [RFC PATCH] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <20110811082515.GB4775@n2100.arm.linux.org.uk>
References: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
	<20110810114907.GA2680@pulham.picochip.com>
	<20110811082515.GB4775@n2100.arm.linux.org.uk>
Message-ID: <20110811084906.GA2732@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 09:25:15AM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 10, 2011 at 12:49:07PM +0100, Jamie Iles wrote:
> > Tested on my 1176 platform and works nicely.  However, shouldn't the 
> > read functions still be marked notrace so they don't appear in ftrace 
> > output?
> > 
> > On my (out of tree) platform, omitting notrace and having all of the 
> > ftrace bootup tests results in a hard lockup.  Annotating the read 
> > function resolves this.
> 
> Why not also convert ftrace to use clocksources ?

I can't say I know enough about ftrace to say what the implications of 
that would be (other than a dependency on all platforms having a 
suitable clocksource).

Jamie
