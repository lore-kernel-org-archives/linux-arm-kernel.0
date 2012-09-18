From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Sep 2012 10:38:54 +0100
Subject: ARM: smp: why don't eliminate warning "Unknown IPI message 0x1"?
In-Reply-To: <CAKvkGKfjShpdTagsHAhyMr3rHfUQc4qpZjW9wMdht4N36Pk5rA@mail.gmail.com>
References: <CAKvkGKfjShpdTagsHAhyMr3rHfUQc4qpZjW9wMdht4N36Pk5rA@mail.gmail.com>
Message-ID: <20120918093853.GW12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 04:07:49PM +0800, ??? wrote:
> Russell King want people to move to SGI0 for this, so that we can have SGI1-N
> as the proper IPIs, but now we can't do this, maybe we must wait for
> so many years.
> But, Do you think we can use a another way to resolve this problem,
> because this warning message will oftenly appeare in products.
> 
> We can't assume the fixed IPI number that can wakeup secondary cores.
> "I'd much rather see platforms deciding whether they need to use SGI1
> or whether they can switch to SGI0 instead."

Why not just fix your platform to use SGI0.  I think we're _finally_
there with everyone using SGI0, which means we can commit the patch
which fixes this.

And anyway, how many of your customers read your kernel log messages?
