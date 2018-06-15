From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Jun 2018 17:43:13 +0100
Subject: [PATCH v2 1/4] arm64: introduce sysreg_clear_set()
In-Reply-To: <20180615162124.jz5655podkezdcu3@armageddon.cambridge.arm.com>
References: <1529077646-2848-1-git-send-email-Dave.Martin@arm.com>
 <1529077646-2848-2-git-send-email-Dave.Martin@arm.com>
 <20180615162124.jz5655podkezdcu3@armageddon.cambridge.arm.com>
Message-ID: <20180615164313.GQ22983@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 05:21:25PM +0100, Catalin Marinas wrote:
> On Fri, Jun 15, 2018 at 04:47:23PM +0100, Dave P Martin wrote:
> > From: Mark Rutland <mark.rutland@arm.com>
> > 
> > Currently we have a couple of helpers to manipulate bits in particular
> > sysregs:
> > 
> >  * config_sctlr_el1(u32 clear, u32 set)
> > 
> >  * change_cpacr(u64 val, u64 mask)
> > 
> > The parameters of these differ in naming convention, order, and size,
> > which is unfortunate. They also differ slightly in behaviour, as
> > change_cpacr() skips the sysreg write if the bits are unchanged, which
> > is a useful optimization when sysreg writes are expensive.
> > 
> > Before we gain more yet another sysreg manipulation function, let's
> > unify these with a common helper, providing a consistent order for
> > clear/set operands, and the write skipping behaviour from
> > change_cpacr(). Code will be migrated to the new helper in subsequent
> > patches.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Dave Martin <dave.martin@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> 
> Since you are submitting this patch, it should have your signed-off-by
> as well. Other than that:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Oops, added locally.

I had considered this optional if the patch was unmodified from the
original author, but I guess I at least applied it on a different base.
In any case, I can see why it would be considered mandatory.

Cheers
---Dave
