From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 Jan 2012 15:46:03 -0500 (EST)
Subject: [RFC PATCH 01/10] rtc: sa1100: include mach/irqs.h instead of
 asm/irq.h
In-Reply-To: <4F106299.8050306@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-2-git-send-email-robherring2@gmail.com>
 <20120113164336.GA1068@n2100.arm.linux.org.uk> <4F106299.8050306@gmail.com>
Message-ID: <alpine.LFD.2.02.1201131536040.2722@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jan 2012, Rob Herring wrote:

> On 01/13/2012 10:43 AM, Russell King - ARM Linux wrote:
> > On Fri, Jan 13, 2012 at 10:34:02AM -0600, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> Since asm/irq.h may not include mach/irqs.h, include mach/irqs.h directly.
> > 
> > Rather than doing this, we should be eliminating the need for these
> > old drivers to include mach/irqs.h at all.
> > 
> > Adding the resources to the platform device, and then using at least
> > the IRQ resource(s) would be a definite step forward (and a relatively
> > easy one to do.)
> > 
> 
> Well, this has just happened in 3.3. So I can now drop this one I think.

Another problem that resources solve (and your original patch didn't 
make it any better nor worse) has to do with include file search paths.  
Once we start building more than one SOC in the kernel, we won't be able 
to support the inclusion of <mach/whatever.h> from driver code anymore 
since this could refer to more than one instances of 
arch/arm/mach-*/include/mach/whatever.h.


Nicolas
