From: joe@perches.com (Joe Perches)
Date: Wed, 26 Nov 2014 07:40:21 -0800
Subject: [PATCH 2/2] MAINTAINERS: ARM Versatile Express platform
In-Reply-To: <1417012855.3972.3.camel@arm.com>
References: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
 <1416967146.8358.19.camel@perches.com> <1417003449.3972.1.camel@arm.com>
 <2667096.evZZoH9ryD@wuerfel> <1417012855.3972.3.camel@arm.com>
Message-ID: <1417016421.19695.1.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-11-26 at 14:40 +0000, Pawel Moll wrote:
> On Wed, 2014-11-26 at 12:17 +0000, Arnd Bergmann wrote:
> > On Wednesday 26 November 2014 12:04:09 Pawel Moll wrote:
> > > 
> > > Right, of course. Whole directory.
> > > 
> > > > F:    */*/vexpress*
> > > 
> > > Cool, didn't think about multiple wildcards. 
> > 
> > Actually, I think you could even do this as
> > 
> > N:	vexpress
> > 
> > which would be even shorter and match most of the other entries too.
> 
> If you think it's safe, fine with me. It would reduce this section to:
> 
> N:	vexpress
> F:	drivers/clocksource/versatile.c

Yes, that's possible too, but:

from MAINTAINERS:

	   scripts/get_maintainer.pl has different behavior for files that
	   match F: pattern and matches of N: patterns.  By default,
	   get_maintainer will not look at git log history when an F: pattern
	   match occurs.  When an N: match occurs, git log history is used
	   to also notify the people that have git commit signatures.

I think it's better to use F: entries because
there is a get_maintainer difference in behavior
between N: and F: entries.

An N: entry means get_maintainer will also cc
patch submitters for these files.

An F: entry will not.
