From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Aug 2011 10:02:48 +0100
Subject: Subject: L2x0 OF properties do not include interrupt #
In-Reply-To: <4E43FDFF.1080401@gmail.com>
References: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
	<201108101624.27881.arnd@arndb.de>
	<20110810142808.GL10121@e102144-lin.cambridge.arm.com>
	<201108111505.11887.arnd@arndb.de>
	<20110811130910.GA10189@e102144-lin.cambridge.arm.com>
	<4E43F5F8.4060704@gmail.com>
	<20110811153800.GC5154@e102144-lin.cambridge.arm.com>
	<4E43FDFF.1080401@gmail.com>
Message-ID: <20110812090248.GI4775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 11:06:23AM -0500, Rob Herring wrote:
> No, either you have 1 interrupt and it is the combined one. or you have
> the 9? separate interrupts.  Having both combined and separate hooked up
> is a bit dumb, so I would not worry about that case. I would just define
> the event counter interrupt 1st as that is probably the primary use.
> Also, I think that was the only interrupt on the L2x0 controllers IIRC.
> 
> It's also conceivable that some of the interrupts get routed somewhere
> else rather than just into the GIC.

A lot of other primecells have the one-combined and individual interrupts.
So far, in the last 10 years, no one's used the individual interrupts in
Linux (or even afaik wired them up.)  Not with either the original ARM
primecells or the vendor modified ones.

That tells us something about the individual interrupts.
