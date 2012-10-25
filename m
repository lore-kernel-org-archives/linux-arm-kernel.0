From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 25 Oct 2012 10:21:46 -0600
Subject: [PATCHv2] arm:socfpga: Enable SMP for socfpga
In-Reply-To: <20121025005735.35b9f971@skate>
References: <1350581567-17229-1-git-send-email-dinguyen@altera.com>
 <20121025005735.35b9f971@skate>
Message-ID: <1351182106.15182.3.camel@dinh-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, 2012-10-25 at 00:57 +0200, Thomas Petazzoni wrote:
> Dear dinguyen at altera.com,
> 
> On Thu, 18 Oct 2012 11:32:47 -0600, dinguyen at altera.com wrote:
> 
> > +static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
> > +{
> > +	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
> > +
> > +	memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
> > +
> > +	__raw_writel(virt_to_phys(secondary_startup), (sys_manager_base_addr+0x10));
> > +
> > +	pen_release = 0;
> 
> Are you sure that this code builds? In your v1, this variable was
> declared in your assembly file, but it is no longer here, and you
> mention in your changelog that it has been removed. But not completely
> apparently.

It builds because pen_release is in <asm/smp.h> for arm. But you're
right, there is no need for this variable anymore. Thanks for the
review.

Dinh
> 
> Best regards,
> 
> Thomas
