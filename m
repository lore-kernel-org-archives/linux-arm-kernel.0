From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 12:14:49 +0000
Subject: [PATCH v6] arm/arm64: add arm-smccc
In-Reply-To: <20151222094606.GA30272@ermac>
References: <1449667495-23091-1-git-send-email-jens.wiklander@linaro.org>
 <20151221111455.GA11145@red-moon> <20151222094606.GA30272@ermac>
Message-ID: <20151222121449.GE8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 10:46:08AM +0100, Jens Wiklander wrote:
> On Mon, Dec 21, 2015 at 11:14:55AM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Dec 09, 2015 at 02:24:55PM +0100, Jens Wiklander wrote:
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index 4e949e5..ce3c0b0 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -564,4 +564,7 @@ config OLD_SIGACTION
> > >  config COMPAT_OLD_SIGACTION
> > >  	bool
> > >  
> > > +config HAVE_ARM_SMCCC
> > > +	bool
> > 
> > It is ok by me to move it there, probably we do not want it at the end of
> > the "ABI hall of shame" list :)
> > 
> > Or drivers/firmware/Kconfig ?
> 
> You tell me, I'm too new here to have a feeling for this.
> 
> > 
> > Strictly speaking, since PSCI uses this by default, you should also
> > enforce an ARM_PSCI_FW dependency on HAVE_ARM_SMCCC.
> 
> ARM_PSCI depends on CPU_V7 and ARM_PSCI_FW doesn't really depend on
> anything today.
> 
> Would it be OK if I changed ARM_PSCI to depend on HAVE_ARM_SMCCC instead
> of CPU_V7 in the "drivers: psci: replace psci firmware calls" patch?
> At the same time I would move the "select HAVE_ARM_SMCCC if CPU_V7" line
> to the "config ARM" block instead in the
> "arm: add implementation for arm-smccc" patch.
> 
> I'll include this change in the v7 patch set if I don't hear anything.

Okay, I think as we don't have a decision on this, the proximity of
Christmas, and the presumable opening of the merge window early in
the new year, I can't merge these patches for the upcoming window.
I'll discard those which have already been submitted to the patch
system.

This also has a knock-on effect on patch 8486/1:

"ARM64: kernel: PSCI: move PSCI idle management code to drivers/firmware"

which is based on top of this series.  If someone wants to replace
that patch with one which has been tested _without_ this series
then I'll look at applying it, provided its only trivially different
from the existing one.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
