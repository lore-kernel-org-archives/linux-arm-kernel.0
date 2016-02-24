From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 21:10:45 +0100
Subject: [PATCH 1/3] dt-bindings: arm/marvell: ABI unstability warning
 about Marvell 7K/8K
In-Reply-To: <20160224172545.GC9137@leverpostej>
References: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1456327007-31008-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160224172545.GC9137@leverpostej>
Message-ID: <20160224211045.379352d3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 24 Feb 2016 17:25:46 +0000, Mark Rutland wrote:

> On Wed, Feb 24, 2016 at 04:16:45PM +0100, Thomas Petazzoni wrote:
> > Since we are still very early in the support of Marvell Armada 7/8K
> > chips and those chips are significantly different from earlier 32 bits
> > Armada SOCs, it is difficult to commit to Device Tree ABI stability at
> > this point.
> 
> I don't see why difference to an existing SoC means that we cannot
> guarantee support for this DT. Why does that contribute to instability?
> 
> If there's something we're unsure about, we should be seeding the DT
> with sufficient information to do the right thing(TM) in future. What
> areas in particular do you think are likely to be problematic? Is there
> anything in particular that you think that approach doesn't work for?

At this point, we have incomplete information about the HW capabilities
and register layout. Our past experience has shown that when we start
supporting SoC that early, 

> From my PoV, if we're so uncertain about a DT binding that it cannot be
> kept supported, it is a prototype not yet fit for mainline.

Are you really serious when you say that ?

The Linux kernel community has been encouraging hardware vendor for
*years* to get their code merged as early as possible. And now that
they are doing it, you are telling them that they shouldn't submit
their code to mainline ?

If that's what you want, then sorry, but I don't buy this argument, and
I will continue to encourage HW vendors to submit their code early,
even if it means that indeed in the early stages, things remain a bit
in-flux and need to be refined progressively.

You seem to really be in your ivory tower and not seeing the reality of
an SoC development and how to push the support for it in mainline as
early as possible, so that the BSPs shipped to actual customers are as
close to mainline as possible. Together with the Marvell engineers, we
are doing a huge amount of work to ensure that this vendor BSP is as
close as mainline as possible. And you're basically telling us we
should this effort ?

Come on, be serious.

> > Therefore, this commit adds a warning to the Marvell 7K/8K DT binding
> > documentation to indicate that the bindings are for the moment
> > unstable.
> 
> As with the other thread, I'm strongly opposed to this mentality.

Many other platforms have made this choice: Atmel, Marvell Berlin, and
probably others.

I think it should be up to each platform vendor to decide whether they
care about DT stability or not, and at which point in time in the life
cycle of their platform they want to claim the DT bindings as stable.
You might believe that DT bindings are stable, but they are not. They
change constantly, in very subtle way, and nobody ever tests DT from
kernel version N-x with kernel version N. On any real-life platform, it
simply doesn't work, unless that platform is 5+ years old.

I made a talk at ELC about DT stability being a fairy tale, and I
remember very well Rob Herring coming to me during the social event
afterwards, telling me that it has never been said that all platforms
should conform strictly to this DT stability requirement.

So please get to an agreement between DT binding maintainers. And stop
saying this ridiculous statement that HW vendors should stop submitting
their code to the mainline.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
