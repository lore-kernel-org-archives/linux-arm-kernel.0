From: nm@ti.com (Nishanth Menon)
Date: Mon, 22 Dec 2014 11:12:42 -0600
Subject: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
In-Reply-To: <20141222170411.GL11502@n2100.arm.linux.org.uk>
References: <5481D913.9040109@ti.com> <5481D9BF.2090007@ti.com>
 <20141209165746.GA29935@kahuna> <54881589.20105@samsung.com>
 <20141211092945.GE11502@n2100.arm.linux.org.uk>
 <54897528.4030804@samsung.com>
 <20141222170411.GL11502@n2100.arm.linux.org.uk>
Message-ID: <CAGo_u6pKUj9x8sCFY0wJCVDkBjT77xetu+XZ+DqWTjEWnvZePA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 11:04 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
>
> Nishanth - can we push OMAP over to using the generic DT L2C
> initialisation (the one from init_IRQ in arch/arm/kernel/irq.c) and
> kill the SoC specific stuff in arch/arm/mach-omap2/omap4-common.c ?
>
> From what I can see, in the DT case, the only thing which is used
> there is the ioremap() to provide omap4_get_l2cache_base() with
> something to return.  Everything else - the initialisation of the
> l2c_write_sec pointer, and the aux mask and values - can be specified
> via the machine_desc struct.

I think this is what Marek proposed. I had requested for patches to be
reposted with linux-omap in CC so that we can test and provide
feedback.

>
> That only leaves the non-DT stuff to worry about this, and from what I
> understand, that's going to be removed soon.  If we're going to keep
> the non-DT stuff, we should implement a new machine_desc hook for it
> instead of hijacking one of the existing callbacks.

none of the PL310 support requires non-DT. PL310 is needed for OMAP4
and AM437x both of which are DT only.


-- 
---
Regards,
Nishanth Menon
