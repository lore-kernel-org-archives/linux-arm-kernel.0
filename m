From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Sep 2016 12:05:58 +0100
Subject: [RFCv4 1/7] drivers/perf: arm_pmu: add common attr group fields
In-Reply-To: <20160909102554.GF20192@arm.com>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
 <1473330112-28528-2-git-send-email-mark.rutland@arm.com>
 <20160909102554.GF20192@arm.com>
Message-ID: <20160909110558.GC10562@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 11:25:54AM +0100, Will Deacon wrote:
> On Thu, Sep 08, 2016 at 11:21:46AM +0100, Mark Rutland wrote:
> > +enum armpmu_attr_groups {
> > +	ARMPMU_ATTR_GROUP_EVENTS,
> > +	ARMPMU_ATTR_GROUP_FORMATS,
> > +	ARMPMU_NR_ATTR_GROUPS
> > +};
> > +
> >  struct arm_pmu {
> >  	struct pmu	pmu;
> >  	cpumask_t	active_irqs;
> > @@ -111,6 +117,7 @@ struct arm_pmu {
> >  	struct pmu_hw_events	__percpu *hw_events;
> >  	struct list_head	entry;
> >  	struct notifier_block	cpu_pm_nb;
> > +	const struct attribute_group *attr_groups[ARMPMU_NR_ATTR_GROUPS + 1];
> 
> Is the '+ 1' because the array has to be NULL terminated?

Yes.

> Probably worth a comment to disuade people from sending "obvious"
> fixes.

Sure. I had meant to do this already, but forgot. :/

Thanks,
Mark.
