From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 19 Apr 2012 12:42:38 -0600
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map;
 use irq_alloc_desc() instead
In-Reply-To: <1334180248.2984.39.camel@pasglop>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost>
 <20120402215524.GM24211@n2100.arm.linux.org.uk>
 <1333406005.30734.61.camel@pasglop>
 <20120402225223.GN24211@n2100.arm.linux.org.uk>
 <1333409927.30734.62.camel@pasglop> <m24nsx9iz1.fsf@igel.home>
 <1333755470.3040.38.camel@pasglop> <m2aa2n7mmw.fsf@igel.home>
 <1334106834.2984.17.camel@pasglop> <1334107996.2984.20.camel@pasglop>
 <1334122182.2984.33.camel@pasglop> <20120411205707.68AC13E08B6@localhost>
 <1334180248.2984.39.camel@pasglop>
Message-ID: <20120419184238.4A6973E0700@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Apr 2012 07:37:28 +1000, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Wed, 2012-04-11 at 14:57 -0600, Grant Likely wrote:
> > 
> > Yeah, I've got a different way to fix it though.  There is exactly one
> > user of irq_virq_count in-tree right now: PS3.  Also, irq_virq_count
> > is only useful for the NOMAP mapping.  So, instead of having a single
> > global irq_virq_count values, I've dropped it entirely and added a
> > max_irq argument to irq_domain_add_nomap().  That makes it a property
> > of an individual nomap irq domain instead of a global system settting.
> > 
> > Hopefully I'll have a draft patch ready today. 
> 
> That works for me. I'll send patches for cleanup MPIC as well.

Okay, I'll wait on these.  The MPIC fixes will need to be applied
before I can apply the automatic revmapping and hint removal patches.
Those patches will also need testing before I apply to linux-next.

g.
