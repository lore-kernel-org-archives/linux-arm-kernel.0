From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Jun 2017 16:43:39 +0100
Subject: [PATCH] arm64: remove a redundancy in sysreg.h
In-Reply-To: <20170620140539.GD21131@arm.com>
References: <20170620133042.mlqgpx5vddgvoe6k@hello-penguin.com>
 <6d18962d-5557-1d57-95da-2ae1c437440b@arm.com>
 <20170620140539.GD21131@arm.com>
Message-ID: <20170620154339.GG21131@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 03:05:39PM +0100, Will Deacon wrote:
> On Tue, Jun 20, 2017 at 02:54:15PM +0100, Marc Zyngier wrote:
> > On 20/06/17 14:30, Stefan Traby wrote:
> > > This is really trivial; there is a dup
> > > (1 << 16) in the code
> > > 
> > > Signed-off-by: Stefan Traby <stefan@hello-penguin.com>
> > > ---
> > >  arch/arm64/include/asm/sysreg.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > > index 2d3e155b185f..580965129fea 100644
> > > --- a/arch/arm64/include/asm/sysreg.h
> > > +++ b/arch/arm64/include/asm/sysreg.h
> > > @@ -139,8 +139,8 @@
> > >  #define SCTLR_ELx_M	1
> > >  
> > >  #define SCTLR_EL2_RES1	((1 << 4)  | (1 << 5)  | (1 << 11) | (1 << 16) | \
> > > -			 (1 << 16) | (1 << 18) | (1 << 22) | (1 << 23) | \
> > > -			 (1 << 28) | (1 << 29))
> > > +			 (1 << 18) | (1 << 22) | (1 << 23) | (1 << 28) | \
> > > +			 (1 << 29))
> > >  
> > >  #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M | SCTLR_ELx_A | SCTLR_ELx_C | \
> > >  			 SCTLR_ELx_SA | SCTLR_ELx_I)
> > > 
> > 
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Catalin, Will: do you want to get that through arm64? Alternatively, I
> > get stash it in the KVM tree.
> 
> I can pick it up.

D'oh, didn't realise that SCTLR_EL2_RES1 was only introduced in -rc5, so I
can't easily take this via arm64 for-next/core (which is based on -rc3). I
don't think it justifies sending as a fix, so if you could take it via KVM
after all, then that would be helpful.

Acked-by: Will Deacon <will.deacon@arm.com>

Sorry for the confusion,

Will
