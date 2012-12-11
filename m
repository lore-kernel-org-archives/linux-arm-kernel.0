From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Dec 2012 23:58:13 -0700
Subject: [PATCH 2/3] ARM: Orion: Bind the orion bridge interrupt
 controller through DT
In-Reply-To: <20121211062430.GD25466@lunn.ch>
References: <1355188683-18208-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1355188683-18208-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <20121211062430.GD25466@lunn.ch>
Message-ID: <20121211065813.GA14843@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	bridge_irq = irq_of_parse_and_map(np, 0);
> > +	/* FIXME: irq_of_parse_and_map returns 0 on error, but on Dove the
> > +	 * bridge IRQ is 0.
> > +	if (!bridge_irq)
> > +		return -ENODEV;*/
> > +
> > +	return orion_bridge_irq_init(bridge_irq, -1, base, np);
> 
> So does this mean for Dove it will currently always fail?

I guess that is hard to read without syntax hi-lighting, the 'if' is
also commented out.

I was hopefull it would work as is, but looking deeper at
irq_of_parse_and_map and its call tree makes me doubtfull now..

Fixing irq_of_parse_and_map is way to big a job for me :(

What to do from here? Add a dummy 0 interrupt to dove? Take dove out
of this patch series?

Jason
