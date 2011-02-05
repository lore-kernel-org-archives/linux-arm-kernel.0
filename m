From: John.Linn@xilinx.com (John Linn)
Date: Sat, 5 Feb 2011 09:20:12 -0700
Subject: [PATCH 1/4] ARM: Xilinx: Adding Xilinx platform
	infrastructuresupport
In-Reply-To: <20110205161610.GB29411@n2100.arm.linux.org.uk>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<cdf64eb9-f50e-4435-92a9-48e161215853@VA3EHSMHS017.ehs.local>
	<20110205161610.GB29411@n2100.arm.linux.org.uk>
Message-ID: <d5717920-de31-4915-8caf-f165711e8ce3@VA3EHSMHS023.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, February 05, 2011 9:16 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org; kernel at vger.kernel.org;
catalin.marinas at arm.com;
> glikely at secretlab.ca
> Subject: Re: [PATCH 1/4] ARM: Xilinx: Adding Xilinx platform
infrastructuresupport
> 
> On Sat, Feb 05, 2011 at 09:08:41AM -0700, John Linn wrote:
> > +config ARCH_XILINX
> > +	bool "Xilinx ARM Cortex A9 Based FPGA"
> > +	select CPU_V7
> 
> Ok, so your platform only supports ARMv7, so you select this symbol.
> 

Yes.  I added linux-kernel list also as I had hosed it up.

> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index 9d30c6f..cf0c6f6 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -415,7 +415,7 @@ config CPU_32v6K
> >
> >  # ARMv7
> >  config CPU_V7
> > -	bool "Support ARM V7 processor" if ARCH_INTEGRATOR ||
MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> > +	bool "Support ARM V7 processor" if ARCH_INTEGRATOR ||
MACH_REALVIEW_EB || MACH_REALVIEW_PBX ||
> ARCH_XILINX
> 
> However, this makes the prompt visible to the user, and with the
'select'
> above, the only possible answer is 'y'.  You don't need to do this -
just
> remove this change.  That means "Support ARM V7 processor" won't be
offered
> to the user, but it will be set in the configuration.

Thanks Russell. Will do.

-- John



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
