From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 Dec 2017 11:53:00 +0100
Subject: [PATCH 1/3] arm64: KVM: Move CPU ID reg trap setup off the world
 switch path
In-Reply-To: <20171205123150.GX22781@e103592.cambridge.arm.com>
References: <1512141582-17474-1-git-send-email-Dave.Martin@arm.com>
 <1512141582-17474-2-git-send-email-Dave.Martin@arm.com>
 <20171205090915.GI32397@cbox>
 <20171205123150.GX22781@e103592.cambridge.arm.com>
Message-ID: <20171206105300.GK32397@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 12:31:51PM +0000, Dave Martin wrote:
> On Tue, Dec 05, 2017 at 10:09:15AM +0100, Christoffer Dall wrote:
> > On Fri, Dec 01, 2017 at 03:19:40PM +0000, Dave Martin wrote:
> > > The HCR_EL2.TID3 flag needs to be set when trapping guest access to
> > > the CPU ID registers is required.  However, the decision about
> > > whether to set this bit does not need to be repeated at every
> > > switch to the guest.
> > > 
> > > Instead, it's sufficient to make this decision once and record the
> > > outcome.
> > > 
> > > This patch moves the decision to vcpu_reset_hcr() and records the
> > > choice made in vcpu->arch.hcr_el2.  The world switch code can then
> > > load this directly when switching to the guest without the need for
> > > conditional logic on the critical path.
> > > 
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > Suggested-by: Christoffer Dall <christoffer.dall@linaro.org>
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> > 
> > > 
> > > ---
> > > 
> > > Note to maintainers: this was discussed on-list [1] prior to the merge
> > > window, but this patch implementing the agreed decision hasn't been
> > > posted previously.
> > > 
> > > This should be considered a fix for v4.15.
> > 
> > It's actually easier for me to apply this for v4.16 and base my VHE
> > optimization patches on it.
> 
> If you're happy for this optimisation to be missing for v4.15, I'm fine
> with that.
> 
> Can I leave it you to pick this up then?

Yes, I applied it to our queue already.

> 
> I'll repost the other stuff from this series separately for Will to
> take care of.
> 

Thanks,
-Christoffer
