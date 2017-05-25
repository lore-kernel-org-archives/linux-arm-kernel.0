From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 May 2017 16:50:42 +0100
Subject: [PATCH 1/1] drivers/perf: arm_pmu_acpi: avoid perf IRQ init when
 guest PMU is off
In-Reply-To: <c11672c5-b167-f50f-2035-40a3db3ec598@redhat.com>
References: <1495636601-14726-1-git-send-email-wei@redhat.com>
 <20170525152814.GR2859@arm.com>
 <c11672c5-b167-f50f-2035-40a3db3ec598@redhat.com>
Message-ID: <20170525155042.GS2859@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 10:49:49AM -0500, Wei Huang wrote:
> On 05/25/2017 10:28 AM, Will Deacon wrote:
> > On Wed, May 24, 2017 at 09:36:41AM -0500, Wei Huang wrote:
> >>  	if (gicc->flags & ACPI_MADT_PERFORMANCE_IRQ_MODE)
> >>  		trigger = ACPI_EDGE_SENSITIVE;
> >>  	else
> >> @@ -58,7 +61,8 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
> >>  		return;
> >>  
> >>  	gsi = gicc->performance_interrupt;
> >> -	acpi_unregister_gsi(gsi);
> >> +	if (gsi)
> >> +		acpi_unregister_gsi(gsi);
> > 
> > ... but then I don't see how we can get here, so I'll drop this hunk.
> 
> I am OK to drop it. It was added just to be cautious... Do you need
> another version from me or you will remove this hunk?

I can drop this hunk, no need to repost.

Thanks,

Will
