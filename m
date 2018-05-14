From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 May 2018 11:08:59 +0100
Subject: [PATCH 02/18] arm64: move SCTLR_EL{1,2} assertions to
 <asm/sysreg.h>
In-Reply-To: <20180514100053.GX7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-3-mark.rutland@arm.com>
 <20180514100053.GX7753@e103592.cambridge.arm.com>
Message-ID: <20180514100858.4xjp5d3axbyy74ap@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 11:00:53AM +0100, Dave Martin wrote:
> On Mon, May 14, 2018 at 10:46:24AM +0100, Mark Rutland wrote:
> > -/* Check all the bits are accounted for */
> > -#define SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != ~0)
> > -
> > +#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffff
> > +#error "Inconsistent SCTLR_EL2 set/clear bits"
> > +#endif
> 
> Can we have a comment on the != 0xffffffff versus != ~0 here?
> 
> The subtle differences in evaluation semantics between #if and
> other contexts here may well trip people up during maintenance...

Do you have any suggestion as to the wording?

I'm happy to add a comment, but I don't really know what to say.

Thanks,
Mark.
