From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 06 Jun 2013 01:27:03 +0200
Subject: getting allwinner SoC support upstream (was Re: Uploading linux
 (3.9.4-1))
In-Reply-To: <CAPweEDzk0T+fZ1aW16D8K4XpvRR2GRrOFtfcjzstnmEJWxmREg@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <19865137.ey1FePPnmD@flatron>
 <CAPweEDzk0T+fZ1aW16D8K4XpvRR2GRrOFtfcjzstnmEJWxmREg@mail.gmail.com>
Message-ID: <31150421.hoVuV4C56M@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 of June 2013 23:38:52 Luke Kenneth Casson Leighton wrote:
> On Wed, Jun 5, 2013 at 10:52 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > Hi Luke,
> 
>  allo tomasz :)
> 
>  ok - much of what you say is duplicated by what russell said, so in
> effect the same reply is relevant, but there's been some cross-over.
> 
> i'll summarise below and cut all but the key question below:
> > I tend to disagree with your view. Is it really our task to convince
> > such companies to work with open source community?
> 
>  their sheer overwhelming success provides us with mass-volume
> ultra-low cost hardware.  to not make an effort to accommodate them
> would in this specific instance be a huge missed opportunity,
> responsibility for which currently falls on the shoulders of the sunxi
> community, where that small community is in no way considered
> "authoritative" as an upstream source and thus every single GNU/Linux
> Distro is left in a position of forcing people to follow insane
> non-standard build procedures that are *way* outside of the capability
> of the average person.
> 
>  so by the linux kernel developers intransigent position, the reach of
> free software as a whole is greatly reduced.  simple logical
> unavoidable conclusion.
> 
>  please feel free - linux kernel developers - to maintain this
> intransigent position for as long as you find it useful to you to do
> so.  btw, that is a sincere statement, devoid and completely free of
> all and any implicit or explicit additional statements and
> implications.

OK, this is a large volume of hardware that can be used to run free 
software, point taken.

Still, I wouldn't really bind having this platform fully upstreamed with 
possibility to run Linux on it. You can take Debian or whatever and just 
boot it with Allwinner's kernel. Sure, probably distribution people would 
shout here about upstream kernel being the only supported, but maybe this 
is the problem, not the lack of support for the platform in upstream 
kernel?

I don't say that having mainline support for this platform wouldn't be 
nice. Sure, it would. But if the company doesn't want to cooperate and 
comply to existing rules, I don't think it can be helped.

> >> > Device tree on ARM's goal is to achieve a single kernel across
> >> > vendors, not just a single kernel for a single vendor.
> >>  
> >>  you'll be aware that i've mentioned a number of times and have
> >> 
> >> discussed at some length why this is a goal that is completely
> >> impossible to achieve [*1].  sadly.
> > 
> > I tend to disagree on this as well, but it's another story. Have read
> > one of the discussions on this topic and it seemed to look more like
> > lobbying for one of the standards being promoted by some company,
> 
>  yeahh, that's rather unfortunate.  i went to some lengths to avoid
> mentioning eoma [*1] until there was a natural point at which it
> became difficult *not* to bring it up, not least because i didn't hear
> anyone else presenting any actual real workable solutions.
> 
> but, you have to bear in mind a couple of things:
> 
> a) i'm a free software developer and advocate.  "business", "lobbying"
> etc. do not come naturally to me.  my associates scream at me
> regularly.
> 
> b) i've been thinking about this incredibly hard problem for at least
> 4 years and almost *all* of my background in computing of the past 30
> years leads me naturally towards actually coming up with a solution
> 
> c) i'm actually really, really really and truly going about *actively*
> implementing that solution rather than just complaining about it *and*
> i'm inviting free software developers to participate, why, because see
> first sentence of a) above.

Basically there are two possible solutions for this problem. You can 
either change the hardware to be standardized or make the software handle 
many different kinds of hardware. Using EOMA would be an example of the 
former, while our approach with Device Tree represents the latter.

Now the key is that Linux is not just about supporting new platforms that 
are going to show up in near future, but also existing ones, that can't be 
magically made standardized. This makes it already too late for ARM for 
such hardware solution, since there is a lot of platforms already not 
using it. ARM64 would be more appropriate to go this way, but you would 
have to make sure that all hardware designers adopt the standard (and I'm 
pretty sure that at some point some low cost hardware design company would 
do things in their own way anyway, breaking the whole idea, just as 
Allwinner did to DT with FEX).

For existing ARM platforms all we can do is make a software-based 
solution, which standardizes the way of hardware description, keeping the 
need to describe the hardware by hand, which is necessary because of 
hardware design.

Best regards,
Tomasz
