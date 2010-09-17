From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 17 Sep 2010 16:41:00 +0530
Subject: [PATCH 02/14] omap: Map only available sram memory
In-Reply-To: <20100917101531.GB27467@n2100.arm.linux.org.uk>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
	<20100917101531.GB27467@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307D10@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, September 17, 2010 3:46 PM
> To: Shilimkar, Santosh
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 02/14] omap: Map only available sram memory
> 
> On Fri, Sep 17, 2010 at 03:17:46PM +0530, Santosh Shilimkar wrote:
> > Currently we map 1 MB section while setting up SRAM on OMAPs.
> > The actual physcal OCM RAM available on OMAP SOCs is in order
> 
> physical
> 
> > of KBs. This patch maps only available sram and removes some
> > non necessary cpu_is_xxx checks.
> >
> > On the newer ARMs with speculation, this is dangerous and can
> > result in untraceable aborts.
> 
> "this" should be expanded (otherwise it is unclear whether it refers to
> the original code or the new code.)

Will fix the change log as below.

omap: Map only available sram memory

Currently we map 1 MB section while setting up SRAM on OMAPs
Regardless of the actual memory. The physical OCM RAM available
on OMAP SOCs is in order of KBs. This patch maps only available
sram and cleans up some un-necessary cpu_is_xxx checks.

Mapping un-available or non-accessible(secure) memory on the newer ARM
processor is dangerous. Because ARM CPUs can now speculatively prefetch,
we should avoid mapping any no-existing or secure memory.
