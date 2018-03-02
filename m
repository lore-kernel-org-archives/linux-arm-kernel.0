From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 2 Mar 2018 12:37:52 +0000
Subject: [RFC PATCH 0.9/2] arm64: fpsimd: Expose CPU / FPSIMD state
 association helpers
In-Reply-To: <20180223170253.GA7396@cbox>
References: <1518805771-15346-1-git-send-email-Dave.Martin@arm.com>
 <1518806370-15697-1-git-send-email-Dave.Martin@arm.com>
 <20180223170253.GA7396@cbox>
Message-ID: <20180302123752.GH32331@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 06:02:53PM +0100, Christoffer Dall wrote:
> On Fri, Feb 16, 2018 at 06:39:30PM +0000, Dave Martin wrote:
> > Oops, forgot to post this patch that goes before patch 1 in the series.
> > 
> > --8<--
> > 
> > Expose an interface for associating an FPSIMD context with a CPU and
> > checking the association, for use by KVM.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---

[...]

> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c

[...]

> > @@ -996,19 +1002,31 @@ void fpsimd_signal_preserve_current_state(void)
> >  		sve_to_fpsimd(current);
> >  }
> >  
> > +static void __fpsimd_bind_to_cpu(struct fpsimd_last_state_struct *last,
> > +				 struct fpsimd_state *st)
> > +{
> > +	WARN_ON(!in_softirq() || !irqs_disabled());
> 
> You meant && here, right?
> 
> Currently this makes my box explode.
> 
> Thanks,
> -Christoffer

Yup, I had fixed that but didn't have enough to be worth reposting yet...

[...]

Cheers
---Dave
