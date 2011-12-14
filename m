From: davidb@codeaurora.org (David Brown)
Date: Wed, 14 Dec 2011 09:46:18 -0800
Subject: [PATCH v4 2/5] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <20111214113655.GA2568@linaro.org>
References: <1323798993-8727-1-git-send-email-dave.martin@linaro.org>
 <1323798993-8727-3-git-send-email-dave.martin@linaro.org>
 <20111213201137.GA31437@huya.qualcomm.com>
 <20111214113655.GA2568@linaro.org>
Message-ID: <20111214174618.GB22025@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 11:36:55AM +0000, Dave Martin wrote:
> On Tue, Dec 13, 2011 at 12:11:37PM -0800, David Brown wrote:
> > On Tue, Dec 13, 2011 at 05:56:30PM +0000, Dave Martin wrote:
> > > Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> > > bothersome to maintain and likely to lead to merge conflicts.
> > 
> > > diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
> > > index ebde97f..e6beaff 100644
> > > --- a/arch/arm/mach-msm/Kconfig
> > > +++ b/arch/arm/mach-msm/Kconfig
> > > @@ -67,6 +67,7 @@ config MSM_SOC_REV_A
> > >  	bool
> > >  config  ARCH_MSM_SCORPIONMP
> > >  	bool
> > > +	select HAVE_SMP
> > >  
> > >  config  ARCH_MSM_ARM11
> > >  	bool
> > 
> > The ARCH_MSM_SCORPIONMP config's only purpose was to enable SMP higher
> > up.  We might as well eliminate ARCH_MSM_SCORPIONMP entirely, and just
> > select HAVE_SMP in ARCH_MSM8X60 and ARCH_MSM8960.
> 
> First and foremost, I'm just refactoring with this series.  I've
> included other trivial changes suggested by other people where the
> effect is clear and straightforward.

In that light, your patch is probably the right approach.  I can clean
our stuff up and sent out other patches later.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
