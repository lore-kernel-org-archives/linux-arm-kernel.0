From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 8 Jul 2011 16:14:49 +0100
Subject: [RFC PATCH 17/17] ARM: kernel: save/restore build infrastructure
In-Reply-To: <4E166B76.7090901@ti.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-18-git-send-email-lorenzo.pieralisi@arm.com>
	<4E166B76.7090901@ti.com>
Message-ID: <20110708151449.GA8071@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 03:29:10AM +0100, Santosh Shilimkar wrote:
> On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> > This patch adds the required Kconfig and Makefile entries to
> > enable and compile common idle code for ARM kernel.
> >
> > Common idle code depends on CPU_PM platform notifiers to trigger
> > save/restore of kernel subsystems like PMU, VFP, GIC.
> >
> > Signed-off-by: Lorenzo Pieralisi<lorenzo.pieralisi@arm.com>
> > ---
> >   arch/arm/Kconfig         |   11 +++++++++++
> >   arch/arm/kernel/Makefile |    4 ++++
> >   2 files changed, 15 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 356f266..5b670bd 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1992,6 +1992,17 @@ config VFP
> >
> >   	  Say N if your target does not have VFP hardware.
> >
> > +config CONTEXT_SR
> 
> SR sounds cryptic. Also since it's PM related _PM_ would
> be good.
> 

Yes, it is cryptic. I did not give it the thought it deserves, I will come
up with something possibly nicer.

> > +	bool "Save/Restore code support for CPU/Cluster Power Management"
> > +	depends on CPU_V7&&  CPU_PM
> 			^
> space needed.

It was there, did it get munged ? I will look into that.

Lorenzo
