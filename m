From: npiggin@gmail.com (Nicholas Piggin)
Date: Thu, 27 Jul 2017 12:08:07 +1000
Subject: [BUG] v4.12 breaks pxa25x
In-Reply-To: <87k22urjwp.fsf@belgarion.home>
References: <87inirsgzk.fsf@belgarion.home>
 <20170717081518.GI31807@n2100.armlinux.org.uk>
 <87eftfrs0e.fsf@belgarion.home> <87o9s7qw64.fsf@belgarion.home>
 <20170726114139.GN31807@n2100.armlinux.org.uk>
 <20170726220334.2961ae22@roar.ozlabs.ibm.com>
 <87k22urjwp.fsf@belgarion.home>
Message-ID: <20170727120807.15148375@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Jul 2017 23:02:46 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Wed, 26 Jul 2017 12:41:39 +0100
> > Russell King - ARM Linux <linux@armlinux.org.uk> wrote:  
> >> Obviously, the mixing of .data.unlikely with the normal .data sections
> >> is undesirable - that looks like it's come from commit b67067f1176d
> >> ("kbuild: allow archs to select link dead code/data elimination") dated
> >> 2016, which according to git describe --contains was merged in v4.9-rc1.
> >> So it's unlikely to be directly caused by this, although this commit is
> >> implicated.
> >> 
> >> I wonder if Nick realised this side effect (that .data.unlikely is no
> >> longer grouped together) - maybe we need to rename .data.unlikely?
> >> (Adding Nick and Michal).  
> >
> > I did to some degree -- hence TEXT was not done that way -- but obviously
> > did not look closely enough.
> >
> > The right short term fix I think is to make those wildcards depend only on
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.
> >
> > One way to avoid clashes with compiler generated section names is to use
> > ".." as separators in our section names.
> >
> > Anyway I'll code up a fix for the linker script that we can get into 4.12,
> > thanks for pointing it out.  
> Ok, cool. I'd like to be copied to your patch so that I can test it please.

Hmm, I intended to cc you, but somehow failed that too. No wonder my
code has bugs :\

It's gone to linux-kbuild and linux-arm-kernel

http://marc.info/?l=linux-kbuild&m=150107320226315&q=raw

Or msg me privately I'll resend it to you.

Thanks,
Nick
