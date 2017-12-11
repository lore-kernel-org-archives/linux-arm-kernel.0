From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Dec 2017 18:02:01 +0000
Subject: [PATCH 2/5] arm_pmu: have armpmu_alloc() take GFP flags
In-Reply-To: <20171211173702.GC3275@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
 <20171101141239.45340-3-mark.rutland@arm.com>
 <20171211173702.GC3275@arm.com>
Message-ID: <20171211180201.x7cc6npex3k2hw2j@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 05:37:02PM +0000, Will Deacon wrote:
> On Wed, Nov 01, 2017 at 02:12:36PM +0000, Mark Rutland wrote:
> > diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> > index 705f1a390e31..a52f5b673a15 100644
> > --- a/drivers/perf/arm_pmu_acpi.c
> > +++ b/drivers/perf/arm_pmu_acpi.c
> > @@ -127,7 +127,7 @@ static struct arm_pmu *arm_pmu_acpi_find_alloc_pmu(void)
> >  		return pmu;
> >  	}
> >  
> > -	pmu = armpmu_alloc();
> > +	pmu = armpmu_alloc(GFP_ATOMIC);
> 
> I think I'd rather have armpmu_alloc_atomic as a wrapper around
> __armpmu_alloc(GFP_ATOMIC) and then leave the armpmu_alloc to pass
> GFP_KERNEL.

Sure; done.

Mark.
