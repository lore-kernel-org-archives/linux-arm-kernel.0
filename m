From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Nov 2009 11:19:56 +0000
Subject: CAS implementation may be broken
In-Reply-To: <20091124013231.GB14645@shareable.org>
References: <20091124013231.GB14645@shareable.org>
Message-ID: <1259061596.13956.15.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-11-24 at 01:32 +0000, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > On Mon, Nov 23, 2009 at 10:28:30PM +0000, Jamie Lokier wrote:
> > > That could be an improvement for some algorithms, because often if the
> > > store doesn't happen, the *inputs* to compare_and_swap() need to be
> > > recalculated anyway before another try is likely to succeed.  What's
> > > the point in having code which expands to two loops:
> >
> > The point is that often its cheaper to retry the LL/SC than it is to
> > do the recalculation.
> >
> > However, I don't think you've understood the original problem at all.
> 
> I think I have - I agreed with you and Catalin already that LL/SC does
> not suffice.  But do you mean that Catalin's suggestion to put the
> LDREX before the LDR does not work either?  (Maybe it needs a barrier
> too).

It definitely needs a barrier after the LDREX and maybe one after STREX
but that depends on the semantics of such operation.

-- 
Catalin
