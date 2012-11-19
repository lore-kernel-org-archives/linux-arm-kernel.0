From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Mon, 19 Nov 2012 17:18:47 +0200
Subject: [PATCH] ARM: add get_user() support for 8 byte types
In-Reply-To: <20121119144806.GO3332@n2100.arm.linux.org.uk>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
 <201211151339.08016.arnd@arndb.de>
 <CAF6AEGuJReNtwUZX6HVZCE8GHuyEAyC8bM0GqZuVMV1=DrGJVw@mail.gmail.com>
 <201211151439.41393.arnd@arndb.de>
 <20121119143236.GA3296@intel.com>
 <20121119144806.GO3332@n2100.arm.linux.org.uk>
Message-ID: <20121119151847.GB3296@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 02:48:06PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 19, 2012 at 04:32:36PM +0200, Ville Syrj?l? wrote:
> > On Thu, Nov 15, 2012 at 02:39:41PM +0000, Arnd Bergmann wrote:
> > > On Thursday 15 November 2012, Rob Clark wrote:
> > > > > I still haven't heard a conclusive argument why we need to use get_user()
> > > > > rather than copy_from_user() in the DRM code. Is this about a fast path
> > > > > where you want to shave off a few cycles for each call, or does this
> > > > > simplify the code structure, or something else?
> > > > 
> > > > well, it is mostly because it seemed like a good idea to first try to
> > > > solve the root issue, rather than having to fix things up in each
> > > > driver when someone from x86-world introduces a 64b get_user()..
> > > 
> > > As pointed out by hpa earlier, x86-32 doesn't have a 64b get_user
> > > either. I don't think we have a lot of drivers that are used only
> > > on 64-bit x86 and on 32-bit ARM but not on 32-bit x86.
> > 
> > Ouch. I didn't realize that x86-32 doesn't have it. All the systems
> > where I've run the new code are 64bit so I never noticed the problem.
> > 
> > I see there was a patch [1] posted a long time ago to implement 64bit
> > get_user() on x86-32. I wonder what happened to it?
> > 
> > [1] https://lkml.org/lkml/2004/4/20/96
> 
> Wonderful lkml.org after four "Negotiating SSL connection..." messages
> gives me under elinks...
<snip> 
> what a wonderful site... please choose another LKML archive, preferably
> one which works.  Thanks.

This one look like the same thing:
http://article.gmane.org/gmane.linux.kernel/198823

-- 
Ville Syrj?l?
Intel OTC
