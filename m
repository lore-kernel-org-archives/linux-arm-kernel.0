From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 12 May 2015 16:24:48 -0700
Subject: [PATCH] MAINTAINERS: add brcmstb regex
In-Reply-To: <1431472250.2884.101.camel@perches.com>
References: <1426727345-5838-1-git-send-email-computersforpeace@gmail.com>
 <20150512230207.GB11598@ld-irv-0074>
 <1431472250.2884.101.camel@perches.com>
Message-ID: <20150512232448.GC11598@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 04:10:50PM -0700, Joe Perches wrote:
> (cc'ing Andrew Morton)
> 
> On Tue, 2015-05-12 at 16:02 -0700, Brian Norris wrote:
> > On Wed, Mar 18, 2015 at 06:09:05PM -0700, Brian Norris wrote:
> > > This could probably consolidate a few file listings. And it satisfies
> > > the spirit of the highly annoying [1] checkpatch warning for every new
> > > file, though it sadly won't quash it.
> > > 
> > > [1] https://lkml.org/lkml/2014/12/17/24
> > > 
> > > Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> > 
> > Ping? Is this a good entry?
> 
> As you're a MAINTAINER of this section, if you want it to
> be a good entry, it's a good entry.

My comment below about MIPS vs. ARM was the key point, and it might
deserve comment from others. Personally, I think it's OK, but it's just
a little strange when linux-arm-kernel becomes a catch-all for all
embedded drivers, even for those that are being utilized on (B)MIPS.

> You should get someone (Andrew?) to apply it.

The "apply" step would be more directed toward Florian, who manages most
of the Broadcom arm-soc trees.

> Be aware that N: matches aren't as "owned" as F: matches.
> 
> Note from MAINTAINERS:
> 	N: Files and directories with regex patterns.
> 	   One pattern per line.  Multiple N: lines acceptable.
> 	   scripts/get_maintainer.pl has different behavior for files that
> 	   match F: pattern and matches of N: patterns.  By default,
> 	   get_maintainer will not look at git log history when an F: pattern
> 	   match occurs.  When an N: match occurs, git log history is used
> 	   to also notify the people that have git commit signatures.
> 
> > One problem is that there may be 'brcmstb' drivers for MIPS as well as
> > ARM. But on that train of thought: there are several drivers which are
> > already somewhat inaccurately-listed. The following are listed under
> > either the BCM7XXX ARM subarchitecture or BMIPS MIPS subarchitecture,
> > though they are actually used on both:
> > 
> >  drivers/bus/brcmstb_gisb.c
> >  drivers/irqchip/irq-brcmstb-l2.c
> >  drivers/irqchip/irq-bcm7120-l2.c

Brian
