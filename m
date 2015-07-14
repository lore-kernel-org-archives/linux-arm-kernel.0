From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Jul 2015 16:51:27 +0100
Subject: [PATCH v2 09/10] arm64/BUG: Use BRK instruction for generic BUG
 traps
In-Reply-To: <20150714113435.GE10670@e103592.cambridge.arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
 <20150713164315.GC22840@leverpostej>
 <20150713165151.GC10670@e103592.cambridge.arm.com>
 <20150713165638.GD22840@leverpostej>
 <20150714102025.GD10670@e103592.cambridge.arm.com>
 <20150714110904.GB12675@leverpostej>
 <20150714113435.GE10670@e103592.cambridge.arm.com>
Message-ID: <20150714155127.GD12675@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 12:34:35PM +0100, Dave P Martin wrote:
> On Tue, Jul 14, 2015 at 12:09:05PM +0100, Mark Rutland wrote:
> > On Tue, Jul 14, 2015 at 11:20:27AM +0100, Dave P Martin wrote:
> > > On Mon, Jul 13, 2015 at 05:56:39PM +0100, Mark Rutland wrote:
> > > > On Mon, Jul 13, 2015 at 05:51:51PM +0100, Dave P Martin wrote:
> > > > > On Mon, Jul 13, 2015 at 05:43:15PM +0100, Mark Rutland wrote:
> > > 
> > > [...]
> > > 
> > > > > > Given the reliance on the labels in the caller, I think it might make
> > > > > 
> > > > > Not sure what you mean here, can you elaborate?
> > > > 
> > > > We're relying on label "0:" in the caller/user of the macro when we emit
> > > > ".long 2b - 0b".
> > > > 
> > > > I think it would be clearer if folded into the caller (even with the
> > > > inline ifdef this necessitates).
> > > > 
> > > > Though I could be missing something here that renders that impossible.
> > > 
> > > Before I respin the series, can you cast your eye over this
> > > alternative?
> > > 
> > > I'm testing it now, but in any case it should make the conditional
> > > structure of the code clearer as per your suggestion.
> > 
> > I think that style of macro is certainly more legible when applied to
> > single lines, but I got a little confused when reading this before I
> > noticed that each __BUGVERBOSE use covered a few lines.
> 
> True, but that's as short a name as I like to define, given that it has
> to stay #defined and this gets included absolutely everywhere.
> 
> I could repeat it on every line and rearrange/reindent things so that
> __BUGVERBOSE doesn't get in the way of the labels, but IMHO that's
> uglier and not really more readable.
> 
> Are we getting into dimishing returns here?

I guess so.

For any of the variants posted in this thread so far:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
