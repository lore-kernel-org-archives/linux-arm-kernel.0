From: John.Linn@xilinx.com (John Linn)
Date: Sat, 5 Feb 2011 09:21:45 -0700
Subject: [PATCH 2/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <20110205161853.GC29411@n2100.arm.linux.org.uk>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<eee52c43-76da-4e47-9f40-4a2d7ee963b6@VA3EHSMHS032.ehs.local>
	<20110205161853.GC29411@n2100.arm.linux.org.uk>
Message-ID: <e5e18153-4d1d-4185-a7c5-165f8c6eec1c@VA3EHSMHS026.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, February 05, 2011 9:19 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org; kernel at vger.kernel.org;
catalin.marinas at arm.com;
> glikely at secretlab.ca
> Subject: Re: [PATCH 2/4] ARM: Xilinx: Adding Xilinx board support
> 
> On Sat, Feb 05, 2011 at 09:08:42AM -0700, John Linn wrote:
> > +void __init irq_init(void)
> > +{
> > +	gic_cpu_base_addr = (void __iomem *)SCU_GIC_CPU_BASE;
> 
> Just pass this address into gic_init - there's no need to initialize
> this variable yourself anymore.

Ok, easy fix.

> 
> > +	gic_init(0, 29, (void __iomem *)SCU_GIC_DIST_BASE,
gic_cpu_base_addr);
> ...
> > +static struct map_desc io_desc[] __initdata = {
> ...
> > +#ifdef CONFIG_DEBUG_LL
> > +	{
> > +		.virtual	= UART0_BASE,
> > +		.pfn		= __phys_to_pfn(UART0_BASE),
> > +		.length		= SZ_4K,
> > +		.type		= MT_DEVICE,
> > +	},
> > +#endif
> 
> You shouldn't need to do this if your addruart macro in
mach/debug-macros.S
> is correctly returning the virtual and physical addresses in rp and
rv.

Ok, will check that and make sure.

Thanks,
John

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
