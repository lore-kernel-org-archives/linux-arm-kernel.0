From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Aug 2012 00:49:45 +0100
Subject: [PATCH 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <503BAEE7.5080401@free-electrons.com>
References: <1345799361-23735-1-git-send-email-gregory.clement@free-electrons.com>
 <1345799361-23735-4-git-send-email-gregory.clement@free-electrons.com>
 <20120824104309.GE5400@mudshark.cambridge.arm.com>
 <5037776A.6050605@free-electrons.com>
 <503BAEE7.5080401@free-electrons.com>
Message-ID: <20120827234944.GB7804@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 06:31:19PM +0100, Gregory CLEMENT wrote:
> On 08/24/2012 02:45 PM, Gregory CLEMENT wrote:
> > On 08/24/2012 12:43 PM, Will Deacon wrote:> On Fri, Aug 24, 2012 at 10:09:18AM +0100, Gregory CLEMENT wrote:
> >> 2. I'm surprised that there aren't barriers and/or maintenance operations
> >>    needed around this operation. It might be worth checking in the
> >>    documentation that you have (you probably need at least an isb()
> >>    following the mcr).
> > 
> > I didn't find any mention of barriers and/or maintenance operations
> > needed around this operation, but maybe I have missed something, or it
> > was implicit for the people who wrote the documentation. I will ask
> > confirmation that we don't need this.
> 
> I've just received confirmation that this register is  r/w from non-secure.
> And that it would be good practice to have an ISB after this MCR, so I
> will add this for the next version coming soon.

That sounds about right, thanks for checking. Can you also confirm that
we don't need an explicit L2 invalidation, like we have for the
memory-mapped interface?

Cheers,

Will
