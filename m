From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 11 Apr 2012 11:33:16 +1000
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <1334106834.2984.17.camel@pasglop>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost>
 <20120402215524.GM24211@n2100.arm.linux.org.uk>
 <1333406005.30734.61.camel@pasglop>
 <20120402225223.GN24211@n2100.arm.linux.org.uk>
 <1333409927.30734.62.camel@pasglop> <m24nsx9iz1.fsf@igel.home>
 <1333755470.3040.38.camel@pasglop> <m2aa2n7mmw.fsf@igel.home>
 <1334106834.2984.17.camel@pasglop>
Message-ID: <1334107996.2984.20.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-04-11 at 11:13 +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2012-04-07 at 14:27 +0200, Andreas Schwab wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> > 
> > > It's arguable that this irq_set_irq_type(,NONE) shouln't be there but
> > > still ... it's been around for ever and things worked :-) So something
> > > -else- is causing the problem and I'd like to understand what exactly.
> > 
> > AFAICS before a09b659cd68c10ec6a30cb91ebd2c327fcd5bfe5
> > irq_set_irq_type(,NONE) was actually a no-op.
> 
> So I'm still a bit baffled... ie, I understand some of what's happening
> but not why it breaks things, I haven't yet managed to reproduce but I
> haven't tried too hard just yet (was away from the HW) :

Allright, I have a repro-case, I'll dig.

Cheers,
Ben.
