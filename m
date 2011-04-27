From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Apr 2011 18:38:57 +0100
Subject: [PATCH] ARM: tegra: consolidate GIC extension usage
In-Reply-To: <BANLkTi=eaTQ4w2j8C4Gs_=-zYdfY1m3Bfw@mail.gmail.com>
References: <1303297104-18887-1-git-send-email-marc.zyngier@arm.com>
	<20110427083657.GI17290@n2100.arm.linux.org.uk>
	<20110427124454.31470c8f@taxman.wild-wind.fr.eu.org>
	<BANLkTi=eaTQ4w2j8C4Gs_=-zYdfY1m3Bfw@mail.gmail.com>
Message-ID: <1303925937.28149.2.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

On Wed, 2011-04-27 at 18:34 +0100, Colin Cross wrote:
> On Wed, Apr 27, 2011 at 4:44 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On Wed, 27 Apr 2011 09:36:57 +0100
> > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> >
> >> On Wed, Apr 20, 2011 at 11:58:24AM +0100, Marc Zyngier wrote:
> >>
> >> A good follow-on step would be...
> >>
> >> >  static void tegra_mask(struct irq_data *d)
> >> >  {
> >> > -   tegra_gic_mask_irq(d);
> >> >     tegra_legacy_mask_irq(d->irq);
> >> >  }
> >>
> >> ... arranging tegra_legacy_mask_irq() etc to take struct irq_data directly.
> >> These functions could then be removed entirely as they serve no useful
> >> purpose other than transforming the new API back to the old API.
> >
> > How about the following patch? I haven't touched the gic_arch_extn part
> > as it would break Will's fastEOI patch set (which depends on this one),
> > but will prepare another patch cleaning up that part.
> 
> I have a patch that fixes all of this and more as part of the Tegra PM
> series, but I was sitting on it assuming Tegra PM would not go into
> 2.6.40.  Let me sort out the cleanups from the PM stuff, and I'll post
> a patch that drops legacy_irq.c entirely.

Ok. Where does that leave my GIC fasteoi stuff? I'm becoming more
conscious of the chained_entry/exit functions sitting there unused in
the kernel and it would be good to get the plumbed into all of the
platforms sooner rather than later.

Ideally your cleanup patch will mean that I don't have to touch the
Tegra irq.c, leaving me with just the GPIO changes (which you can Ack if
you like :).

Cheers,

Will
