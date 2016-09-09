From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Sep 2016 12:04:50 +0100
Subject: [RFCv4 5/7] drivers/perf: arm_pmu: expose a cpumask in sysfs
In-Reply-To: <20160909102443.GE20192@arm.com>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
 <1473330112-28528-6-git-send-email-mark.rutland@arm.com>
 <20160909102443.GE20192@arm.com>
Message-ID: <20160909110450.GB10562@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 11:24:43AM +0100, Will Deacon wrote:
> On Thu, Sep 08, 2016 at 11:21:50AM +0100, Mark Rutland wrote:
> > +static ssize_t armpmu_cpumask_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf)
> > +{
> > +	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
> > +	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
> > +}
> > +
> > +static struct device_attribute armpmu_cpumask_attr =
> > +		__ATTR(cpus, S_IRUGO, armpmu_cpumask_show, NULL);
> 
> You can use the DEVICE_ATTR macro for this.

Ok. I've made use of this locally.

I'll send an updated version of the patches shortly, once I've given
this a spin on HW 

Mark.
