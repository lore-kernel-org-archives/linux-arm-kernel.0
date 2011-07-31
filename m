From: jamie@jamieiles.com (Jamie Iles)
Date: Sun, 31 Jul 2011 16:27:14 +0100
Subject: [PATCH 1/3] vic: add device tree bindings
In-Reply-To: <20110731041107.GN24334@ponder.secretlab.ca>
References: <1311610200-12408-1-git-send-email-jamie@jamieiles.com>
	<1311610200-12408-2-git-send-email-jamie@jamieiles.com>
	<20110725200434.GB26735@ponder.secretlab.ca>
	<20110725223151.GB3001@gallagher>
	<20110731041107.GN24334@ponder.secretlab.ca>
Message-ID: <20110731152714.GB7094@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2011 at 10:11:07PM -0600, Grant Likely wrote:
> On Mon, Jul 25, 2011 at 11:31:51PM +0100, Jamie Iles wrote:
> > 
> > > > +	}
> > > 
> > > I think that rather than writing a interrupt-controller-specific
> > > parse route like this one, it would be much better to have a generic
> > > helper that finds and sorts all the interrupt controllers before
> > > calling a setup callback for each one.
> > 
> > Hmm, not sure I follow this.  I can see that many controllers would have 
> > some common properties so there will be some common code - are you 
> > suggesting having something do all the parsing then callbacks for each 
> > controller type that takes some kind of template or am I way off the 
> > mark?
> 
> No, I'm more talking about having a routine that finds all the
> interrupt controllers and figures out the cascading order, and then
> calls each irq controller setup routine in order.

OK, that makes sense.  I'm not sure how best to implement that but I'll 
give it some thought.

Regarding the irq-start property - on picoxcell we have 2 VIC's and they 
aren't cascaded - the outputs are just OR'd together so I can't work out 
how to fit in the IRQ decoding with get_irqnr_and_base without having 
this property.  Is there another way that I could implement that?

Jamie
