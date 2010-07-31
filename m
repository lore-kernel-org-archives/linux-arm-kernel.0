From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 31 Jul 2010 20:18:05 +0530
Subject: [PATCH] ARM: update show_interrupts for online cpu's only
In-Reply-To: <20100731143627.GC27064@n2100.arm.linux.org.uk>
References: <1280585333-4870-1-git-send-email-santosh.shilimkar@ti.com>
	<20100731143627.GC27064@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C638105A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, July 31, 2010 8:06 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: update show_interrupts for online cpu's only
> 
> On Sat, Jul 31, 2010 at 07:38:53PM +0530, Santosh Shilimkar wrote:
> > Even after CPUx is logically offline, it's interrupt are displayed
> > in proc entry
> >
> > This patch fixes the same by use of 'for_each_online_cpu' instead
> > of 'for_each_present_cpu' in 'show_interrupts' function
> 
> What's the synchronisation mechanism between CPUs being brought on or
> offline and this file being read?
>
Isn't that taken care by "cpu_online_mask" mask ?
 
> I believe we have a more dynamic approach to CPU hotplug (using it for
> dynamic power saving) than x86, so I believe hotplug events can happen
> more often on ARM.
Most likely yes.
