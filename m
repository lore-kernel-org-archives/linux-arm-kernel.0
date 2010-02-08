From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 8 Feb 2010 11:52:10 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1265622676.4020.19.camel@pc1117.cambridge.arm.com>
References: <20100208065519.GE1290@ucw.cz>
	<1265622676.4020.19.camel@pc1117.cambridge.arm.com>
Message-ID: <20100208105209.GA31671@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi,
> 
> On Mon, 2010-02-08 at 06:55 +0000, Pavel Machek wrote:
> > > > So, let's put this in the HCD drivers and be done with it.
> > >
> > > The patch below is what fixes the I-D cache incoherency issues on ARM. I
> > > don't particularly like the solution but it seems to be the only one
> > > available.
> > 
> > Really? It looks like arm should just flush the caches when mapping
> > executable page to the userspace.... you can't expect all the drivers
> > to be modified like that...
> 
> We could of course flush the caches every time we get a page fault but
> that's far from optimal, especially since DMA-capable drivers to do
> not

Maybe far for optimal, but it is something that should be done,
_first_. Correctness is more important than performance, and you can't
expect all drivers to behave like you want them.

Then you can add optimalizations not to do the flushes on drivers you
audited and where you care...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
