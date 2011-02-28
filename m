From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 28 Feb 2011 09:15:52 +0530
Subject: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operationcan
	cause data corruption
In-Reply-To: <20110227120021.GA15314@n2100.arm.linux.org.uk>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
	<1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
	<20110227120021.GA15314@n2100.arm.linux.org.uk>
Message-ID: <680a3e4f3107f4fcb10f98bd0a589d1c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Sunday, February 27, 2011 5:30 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; tony at atomide.com;
> catalin.marinas at arm.com; linux-omap at vger.kernel.org
> Subject: Re: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way
> operationcan cause data corruption
>
> On Fri, Feb 18, 2011 at 06:05:24PM +0530, Santosh Shilimkar wrote:

[...]

>
> > @@ -329,6 +330,7 @@ void __init l2x0_init(void __iomem *base,
> __u32 aux_val, __u32 aux_mask)
> >  	outer_cache.flush_all = l2x0_flush_all;
> >  	outer_cache.inv_all = l2x0_inv_all;
> >  	outer_cache.disable = l2x0_disable;
> > +	outer_cache.set_debug = NULL;
>
> 	outer_cache.set_debug = l2x0_set_debug;
>
> may result in more efficient code as we're avoiding having to test
> the value of outer_cache.set_debug each time we want to call it and
> branch appropriately.

Ok. Will do the necessary change and submit it to patch System

Regards,
Santosh
