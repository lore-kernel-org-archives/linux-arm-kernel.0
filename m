From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 4 Jan 2016 13:26:00 +0100
Subject: [PATCH v6] arm/arm64: add arm-smccc
In-Reply-To: <20160104121401.GA698@red-moon>
References: <1449667495-23091-1-git-send-email-jens.wiklander@linaro.org>
 <20151221111455.GA11145@red-moon> <20151222094606.GA30272@ermac>
 <20160104121401.GA698@red-moon>
Message-ID: <20160104122559.GA8705@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 12:14:01PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 22, 2015 at 10:46:08AM +0100, Jens Wiklander wrote:
> > On Mon, Dec 21, 2015 at 11:14:55AM +0000, Lorenzo Pieralisi wrote:
> > > On Wed, Dec 09, 2015 at 02:24:55PM +0100, Jens Wiklander wrote:
> > > > Adds helpers to do SMC and HVC based on ARM SMC Calling Convention.
> > > > CONFIG_HAVE_ARM_SMCCC is enabled for architectures that may support the
> > > > SMC or HVC instruction. It's the responsibility of the caller to know if
> > > > the SMC instruction is supported by the platform.
> > > > 
> > > > This patch doesn't provide an implementation of the declared functions.
> > > > Later patches will bring in implementations and set
> > > > CONFIG_HAVE_ARM_SMCCC for ARM and ARM64 respectively.
> > > > 
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > > 
> > > > v6:
> > > > * Move HAVE_ARM_SMCCC from init/Kconfig
> > > > 
> > > >  arch/Kconfig              |  3 ++
> > > >  include/linux/arm-smccc.h | 98 +++++++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 101 insertions(+)
> > > >  create mode 100644 include/linux/arm-smccc.h
> > > > 
> > > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > > index 4e949e5..ce3c0b0 100644
> > > > --- a/arch/Kconfig
> > > > +++ b/arch/Kconfig
> > > > @@ -564,4 +564,7 @@ config OLD_SIGACTION
> > > >  config COMPAT_OLD_SIGACTION
> > > >  	bool
> > > >  
> > > > +config HAVE_ARM_SMCCC
> > > > +	bool
> > > 
> > > It is ok by me to move it there, probably we do not want it at the end of
> > > the "ABI hall of shame" list :)
> > > 
> > > Or drivers/firmware/Kconfig ?
> > 
> > You tell me, I'm too new here to have a feeling for this.
> > 
> > > 
> > > Strictly speaking, since PSCI uses this by default, you should also
> > > enforce an ARM_PSCI_FW dependency on HAVE_ARM_SMCCC.
> > 
> > ARM_PSCI depends on CPU_V7 and ARM_PSCI_FW doesn't really depend on
> > anything today.
> > 
> > Would it be OK if I changed ARM_PSCI to depend on HAVE_ARM_SMCCC instead
> > of CPU_V7 in the "drivers: psci: replace psci firmware calls" patch?
> > At the same time I would move the "select HAVE_ARM_SMCCC if CPU_V7" line
> > to the "config ARM" block instead in the
> > "arm: add implementation for arm-smccc" patch.
> > 
> > I'll include this change in the v7 patch set if I don't hear anything.
> 
> Sorry for the delay in getting back to you.
> 
> Yes, I still think that HAVE_ARM_SMCCC should not be listed at the
> end of "ABI hall of shame" in arch/Kconfig and you can move it to
> drivers/firmware/Kconfig.
> 
> Other than that your v7 is fine by me, can you respin quickly and
> ask Russell to pull today please ?

OK, I'll do that asap. 

Thanks,
Jens
