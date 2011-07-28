From: davidb@codeaurora.org (David Brown)
Date: Thu, 28 Jul 2011 14:00:41 -0700
Subject: [PATCH 2/2] ARM: msm: Remove PLAT_PHYS_OFFSETS from MSM targets
In-Reply-To: <alpine.LFD.2.00.1107281647060.12766@xanadu.home>
References: <1311794355-26988-2-git-send-email-sboyd@codeaurora.org>
	<1311884291-5409-1-git-send-email-davidb@codeaurora.org>
	<1311884291-5409-2-git-send-email-davidb@codeaurora.org>
	<alpine.LFD.2.00.1107281647060.12766@xanadu.home>
Message-ID: <20110728210041.GA7983@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2011 at 04:49:18PM -0400, Nicolas Pitre wrote:
> On Thu, 28 Jul 2011, David Brown wrote:
> 
> > Now that MSM can boot with the phys offset patching, eliminate the
> > definitions of the phys offsets, and instead select
> > ARM_PATCH_PHYS_VIRT.
> > 
> > Signed-off-by: David Brown <davidb@codeaurora.org>
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index ced9371..3a4d87c 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -618,6 +618,7 @@ config ARCH_MSM
> >  	select GENERIC_CLOCKEVENTS
> >  	select ARCH_REQUIRE_GPIOLIB
> >  	select CLKDEV_LOOKUP
> > +	select ARM_PATCH_PHYS_VIRT
> >  	help
> >  	  Support for Qualcomm MSM/QSD based systems.  This runs on the
> >  	  apps processor of the MSM/QSD and depends on a shared memory
> > diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
> > index 58d5e7e..deed41a 100644
> > --- a/arch/arm/mach-msm/include/mach/memory.h
> > +++ b/arch/arm/mach-msm/include/mach/memory.h
> > @@ -17,19 +17,12 @@
> >  #define __ASM_ARCH_MEMORY_H
> >  
> >  /* physical offset of RAM */
> > -#if defined(CONFIG_ARCH_QSD8X50) && defined(CONFIG_MSM_SOC_REV_A)
> > -#define PLAT_PHYS_OFFSET		UL(0x00000000)
> > -#elif defined(CONFIG_ARCH_QSD8X50)
> > -#define PLAT_PHYS_OFFSET		UL(0x20000000)
> > -#elif defined(CONFIG_ARCH_MSM7X30)
> > -#define PLAT_PHYS_OFFSET		UL(0x00000000)
> > -#elif defined(CONFIG_ARCH_MSM8X60)
> > -#define PLAT_PHYS_OFFSET		UL(0x40000000)
> > -#elif defined(CONFIG_ARCH_MSM8960)
> > -#define PLAT_PHYS_OFFSET		UL(0x40000000)
> > -#else
> > -#define PLAT_PHYS_OFFSET		UL(0x10000000)
> > -#endif
> > +#define QSD8X50A_PHYS_OFFSET		UL(0x00000000)
> > +#define QSD8X50_PHYS_OFFSET		UL(0x20000000)
> > +#define MSM7X30_PHYS_OFFSET		UL(0x00000000)
> > +#define MSM8X60_PHYS_OFFSET		UL(0x10000000)
> > +#define MSM8960_PHYS_OFFSET		UL(0x40000000)
> > +#define MSM7X01_PHYS_OFFSET		UL(0x10000000)
> 
> Do you really need those defines?  If you do I'd suggest moving them 
> elsewhere so your mach/memory.h can become empty.

Currently, they aren't needed at all.  I'll just remove them entirely
until something needs them.  The values will be in the history.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
