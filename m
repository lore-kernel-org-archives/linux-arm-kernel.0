From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Thu, 31 Aug 2017 13:18:27 +0200
Subject: [RFC PATCH v9 5/7] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170831103119.GC15031@leverpostej>
References: <20170829131238.4988-1-jglauber@cavium.com>
 <20170829131238.4988-6-jglauber@cavium.com>
 <a89f597e-885d-a8bd-f6ce-452d7025cb20@hisilicon.com>
 <20170831095746.GB15906@hc> <20170831103119.GC15031@leverpostej>
Message-ID: <20170831111827.GD15906@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 11:31:20AM +0100, Mark Rutland wrote:
> On Thu, Aug 31, 2017 at 11:57:46AM +0200, Jan Glauber wrote:
> > On Wed, Aug 30, 2017 at 10:54:03AM +0800, Zhangshaokun wrote:
> > > On 2017/8/29 21:12, Jan Glauber wrote:

[...]

> > > > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > > > index 82b30e6..ca84ac8 100644
> > > > --- a/include/linux/cpuhotplug.h
> > > > +++ b/include/linux/cpuhotplug.h
> > > > @@ -139,6 +139,7 @@ enum cpuhp_state {
> > > >  	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
> > > >  	CPUHP_AP_WORKQUEUE_ONLINE,
> > > >  	CPUHP_AP_RCUTREE_ONLINE,
> > > > +	CPUHP_AP_PERF_ARM_CVM_ONLINE,
> > > 
> > > Alphabetic order?
> > 
> > These don't look alphabetically ordered to me.
> 
> Sure, the full list is ordered by dependency.
> 
> However, we've generally kept the uncore PMUs together, and within the
> group of system PMU CPUHP_AP_PERF_ARM_* callbacks, we've retained
> alphabetical order.
> 
> Does this PMU need workqueues and RCU up before its HP callback is
> invoked? Or can this be moved into the group of CPUHP_AP_PERF_ARM_*
> above CPUHP_AP_WORKQUEUE_ONLINE and CPUHP_AP_RCUTREE_ONLINE? i.e.
> between CPUHP_AP_PERF_ARM_CCN_ONLINE and CPUHP_AP_PERF_ARM_L2X0_ONLINE.

I think I can move it inside the CPUHP_AP_PERF_ARM_* group.

--Jan

> THanks,
> Mark.
