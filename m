From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 12 Jun 2014 08:47:05 +0100
Subject: [GIT PULL] mfd: Immutable branch between MFD and OMAP, due for
 v3.16
In-Reply-To: <20140612054348.GC17845@atomide.com>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
 <20140528071313.GH4227@lee--X1> <20140528180607.GB4707@atomide.com>
 <20140602163841.GC11004@atomide.com>
 <20140603080632.GC3060@lee--X1>
 <20140612054348.GC17845@atomide.com>
Message-ID: <20140612074705.GB11421@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jun 2014, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [140603 01:08]:
> > On Mon, 02 Jun 2014, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [140528 11:11]:
> > > > * Lee Jones <lee.jones@linaro.org> [140528 00:14]:
> > > > > Thanks Tony, here's the pull-request:
> > > > > 
> > > > > The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:
> > > > > 
> > > > >   Linux 3.14 (2014-03-30 20:40:15 -0700)
> > > > > 
> > > > > are available in the git repository at:
> > > > > 
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-omap-v3.16-1
> > > > > 
> > > > > for you to fetch changes up to 43fef47f94a1ae46fb2720dada32fa3b5547bee2:
> > > > > 
> > > > >   mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle (2014-05-28 08:06:18 +0100)
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > Second immutable branch between MFD and OMAP due for the v3.16 merge window.
> > > > 
> > > > Thanks a lot, this will make it easier for me to chase down potential
> > > > PM related regressions ;) I'm merging this for testing only into the
> > > > linux-omap master branch, no need for me to include it into any
> > > > of my upstream heading branches.
> > > 
> > > Lee, I'm not seeing this in linux next, did you maybe forget to merge
> > > it into the MFD tree?
> > 
> > I didn't forget, but I didn't do it either. :)
> > 
> > I have re-merged all of the IBs this morning, so should be in -next
> > by tomorrow.
> 
> Still not seeing this branch being merged..

Oh crap, I see what's happened and it's completely my fault.

If you read the final merge commit carefully:

28fee3f: ("Merge branches 'ib-from-asoc-3.16', 'ib-from-pm-3.16',
'ib-from-regulator-3.16', 'ib-mfd-gpio-3.16' and
'ib-mfd-mmc-memstick-3.16', tags 'ib-mfd-extcon-3.16',
'ib-mfd-omap-3.16' and 'ib-mfd-regulator-3.16' into
ibs-for-mfd-merged")

I appear to have a _branch_ AND a _tag_ called ib-mfd-omap-3.16 and it
looks like Git has taken the tag as a preference. heads/ib-mfd-omap-3.16
is actually at tag/ib-mfd-omap-3.16-1 (notice the appended '-1'),
which contains your most recent patches.  Since I created the MFD-OMAP
shared branch I have changed the naming convention to avoid this sort
of ambiguity.  I'll send a second MFD pull-request to Linus today.

Sorry Tony.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
