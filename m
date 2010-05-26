From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 26 May 2010 19:31:11 +0200
Subject: [PATCH 2/7 v5] Add the clock framework for Telechips TCC8xxx
	processors.
In-Reply-To: <20100422111917.GE20008@n2100.arm.linux.org.uk>
References: <20100421123814.GC1995@bluebox.local>
	<20100421124159.GE1995@bluebox.local>
	<20100422111917.GE20008@n2100.arm.linux.org.uk>
Message-ID: <20100526173111.GB2006@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 22, 2010 at 12:19:17PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 21, 2010 at 02:42:01PM +0200, Hans J. Koch wrote:
> > +static int __set_parent(struct clk *clock, struct clk *parent)
> > +{
> > +	if (clock->parent && (clock->parent != parent)) {
> > +		clock->parent->refcount--;
> > +		if ((clock->parent->refcount == 0) && clock->parent->disable)
> > +			clock->parent->disable(clock->parent);
> > +	}
> > +
> > +	clock->parent = parent;
> > +	if (clock->parent)
> > +		clock->parent->refcount++;
> 
> Is this left over from the old clk_set_parent() implementation - with
> the handling of refcounting in the main clk_set_parent(), this refcounting
> seems unnecessary (and seems buggy.)

Right. All refcounting is already done in plat-tcc/clock.c, so this
__set_parent() became obsolete. I removed it completely, because the initial
parent setting is already done elsewhere.

Thanks,
Hans
