From: joe@perches.com (Joe Perches)
Date: Thu, 12 Jun 2014 07:18:31 -0700
Subject: [PATCH V2 08/19] irqchip: crossbar: fix checkpatch warning
In-Reply-To: <5399AC9C.4080602@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-9-git-send-email-r.sricharan@ti.com>
 <20140612131042.GU8664@titan.lakedaemon.net> <5399AC9C.4080602@ti.com>
Message-ID: <1402582711.9947.17.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-06-12 at 19:05 +0530, Sricharan R wrote:
> On Thursday 12 June 2014 06:40 PM, Jason Cooper wrote:
> > On Thu, Jun 12, 2014 at 05:23:16PM +0530, Sricharan R wrote:
> >> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
[]
> >> @@ -34,7 +34,8 @@ struct crossbar_device {
> >>  	uint *irq_map;
> >>  	void __iomem *crossbar_base;
> >>  	int *register_offsets;
> >> -	void (*write) (int, int);
> >> +
> >> +	void (*write)(int, int);
> > 
> > The empty line here looks bogus to me.

Good eye.  It's unnecessary.

>   Did you re-run checkpatch after
> > fixing the unnecessary space to see if it still complained about having
> > a 'blank line after declarations'?
> > 
>  Yes, it still complains even after fixing unnecessary space.

It's a checkpatch defect.

It's been fixed by:
https://lkml.org/lkml/2014/6/6/426

> > I'm generally opposed to these sorts of checkpatch patches, especially
> > when they are just warnings.  It's great for a new driver in the staging
> > tree, but it makes backporting future bugfixes that much harder when
> > drivers have been live in mainline.

Blind adherence to checkpatch isn't always a great idea.

But bugfix backports haven't been much of an issue in
other subsystems with fairly active whitespace/style
changes.
