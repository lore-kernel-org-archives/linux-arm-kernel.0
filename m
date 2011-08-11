From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Aug 2011 17:34:27 +0100
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
Message-ID: <20110811163427.GD5154@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 05:06:23PM +0100, Rob Herring wrote:
> On 08/11/2011 10:38 AM, Will Deacon wrote:
> > 
> > You mean putting the combined interrupt first? If so, we may as well just
> > specify that until somebody builds a platform that doesn't have it.
> > 
> 
> No, either you have 1 interrupt and it is the combined one. or you have
> the 9? separate interrupts.  Having both combined and separate hooked up
> is a bit dumb, so I would not worry about that case. I would just define
> the event counter interrupt 1st as that is probably the primary use.
> Also, I think that was the only interrupt on the L2x0 controllers IIRC.
> 
> It's also conceivable that some of the interrupts get routed somewhere
> else rather than just into the GIC.

Ok. I think the binding that Mark posted to devicetree-discuss:

http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-August/007349.html

will take care of this. We have a single interrupt (I don't think we even
need to specify what it is). Interrupt handlers can request this with
IRQ_SHARED and then check the status register to see whether they actually
need to do anything.

Will
