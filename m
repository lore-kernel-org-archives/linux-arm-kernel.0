From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 27 Jul 2011 09:48:11 +0100
Subject: [RFC PATCH 17/17] ARM: kernel: save/restore build infrastructure
In-Reply-To: <CAK44p23WC9F59JoN1TjhDDcMqTEB7+v25cNAfBprFECo9=6FLw@mail.gmail.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-18-git-send-email-lorenzo.pieralisi@arm.com>
	<CAK44p23WC9F59JoN1TjhDDcMqTEB7+v25cNAfBprFECo9=6FLw@mail.gmail.com>
Message-ID: <20110727084811.GA802@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 01:14:26PM +0100, Amit Kachhap wrote:
> On 7 July 2011 21:20, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > This patch adds the required Kconfig and Makefile entries to
> > enable and compile common idle code for ARM kernel.
> >
> > Common idle code depends on CPU_PM platform notifiers to trigger
> > save/restore of kernel subsystems like PMU, VFP, GIC.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm/Kconfig         |   11 +++++++++++
> >  arch/arm/kernel/Makefile |    4 ++++
> >  2 files changed, 15 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 356f266..5b670bd 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1992,6 +1992,17 @@ config VFP
> >
> >          Say N if your target does not have VFP hardware.
> >
> > +config CONTEXT_SR
> > +       bool "Save/Restore code support for CPU/Cluster Power Management"
> > +       depends on CPU_V7 && CPU_PM
> > +       help
> > +         Say Y to include Save/Restore code in the kernel. This provides
> > +         generic infrastructure to put the code in dormant/shutdown mode
> > +         and save/restore the required system state inclusive of L2 cache
> > +         logic.
> > +
> > +         Say N if your target does not have Power Management hardware.
> > +
> 
> Currently this is placed inside the "Floating point emulation" menu.
> "cpu power management" menu may be a better option.
> Also I did not find where configs CPU_PM,  ARCH_USES_CPU_PM are enabled.
> 

Yes Amit, I fixed that, thanks for looking at this.
CPU_PM and ARCH_USES_CPU_PM are defined in PATCH 2 of this series from
Colin, which adds the infrastructure for cpu PM notifiers.

Thanks,
Lorenzo
