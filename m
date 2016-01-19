From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 19 Jan 2016 11:59:50 +0000
Subject: [PATCH 04/19] arm64: Cleanup SCTLR flags
In-Reply-To: <569CBA82.9050102@arm.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <701b44f00cdb8dbc7881c12508f55e993b9ce6dd.1452884156.git.geoff@infradead.org>
 <20160115200727.GQ3262@leverpostej> <569CBA82.9050102@arm.com>
Message-ID: <20160119115946.GC4436@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 10:12:18AM +0000, Marc Zyngier wrote:
> On 15/01/16 20:07, Mark Rutland wrote:

[...]

> > Marc, Christoffer, I note that in SCTLR_EL2_FLAGS we don't set the RES1
> > bits of SCTLR_EL2 (not in head.S el2_setup). Should we perhaps be doing
> > so so as to avoid any future surprises?
> 
> Yes, that's one of the numerous instances of the same problem - I think
> Dave Martin also has some fixes in that area.
> 
> I'll definitely take patches!

Yep, we have a similar problem with CPTR_EL2, patch to follow at some
point.  There are likely other instances...

Cheers
---Dave
