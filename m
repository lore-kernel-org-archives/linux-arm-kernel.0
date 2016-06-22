From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Jun 2016 16:46:13 +0100
Subject: [PATCH] xen/arm: register clocks used by the hypervisor
In-Reply-To: <576AAE36.9070501@arm.com>
References: <1466504165-9214-1-git-send-email-dirk.behme@de.bosch.com>
 <576AAE36.9070501@arm.com>
Message-ID: <20160622154613.GC31817@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 04:26:46PM +0100, Julien Grall wrote:
> Hello Dirk,
> 
> On 21/06/16 11:16, Dirk Behme wrote:
> >Some clocks might be used by the Xen hypervisor and not by the Linux
> >kernel. If these are not registered by the Linux kernel, they might be
> >disabled by clk_disable_unused() as the kernel doesn't know that they
> >are used. The clock of the serial console handled by Xen is one
> >example for this. It might be disabled by clk_disable_unused() which
> >stops the whole serial output, even from Xen, then.
> >
> >Up to now, the workaround for this has been to use the Linux kernel
> >command line parameter 'clk_ignore_unused'. See Xen bug
> >
> >http://bugs.xenproject.org/xen/bug/45
> >
> >too.
> >
> >To fix this, we will add the "unused" clocks in Xen to the hypervisor
> >node. The Linux kernel has to register the clocks from the hypervisor
> >node, then.
> >
> >Therefore, check if there is a "clocks" entry in the hypervisor node
> >and if so register the given clocks to the Linux kernel clock
> >framework and with this mark them as used. This prevents the clocks
> >from being disabled.
> 
> This new property would need to be documented in:
>    - linux/Documentation/devicetree/bindings/arm/xen.txt
>    - xen/docs/misc/arm/device-tree/guest.txt

This (series) should also be CC'd to devicetree at vger.kernel.org, and to
the clock framework maintainers.

I have further questions, but I will wait for that posting.

Thanks,
Mark.
