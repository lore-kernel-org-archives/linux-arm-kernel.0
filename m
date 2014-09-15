From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Mon, 15 Sep 2014 20:45:18 +0100
Subject: [PATCH v5 10/12] sched: get CPU's utilization statistic
In-Reply-To: <20140911140444.GH4783@worktop.ger.corp.intel.com>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-11-git-send-email-vincent.guittot@linaro.org>
 <20140911123412.GY3190@worktop.ger.corp.intel.com>
 <CAKfTPtBbjpCFifoyFSh8Hb3nBZFFTjjxdfxnpMk=CHy5aX1qpg@mail.gmail.com>
 <20140911140444.GH4783@worktop.ger.corp.intel.com>
Message-ID: <20140915194518.GC28083@e103687>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 03:04:44PM +0100, Peter Zijlstra wrote:
> On Thu, Sep 11, 2014 at 03:07:52PM +0200, Vincent Guittot wrote:
> > > Also I'm not entirely sure I like the usage, utilization names/metrics.
> > > I would suggest to reverse them. Call the pure running number
> > > 'utilization' and this scaled with capacity 'usage' or so.
> > 
> > ok. i can invert 'usage' and 'utilization', which will give
> > 
> > s/get_cpu_utilization/get_cpu_usage/
> > s/sgs->group_utilization/sgs->group_usage/

The confusion will have new dimensions added when we introduce
scale-invariance too. Then the running number is already scaled by the
current P-state compute capacity. But I don't have any better
suggestions. 

> > s/cfs.usage_load_avg/cfs.utilization_load_avg/

I don't like using "load" for unweighted metrics. I associate load with
something that may be weighted by priority like load_avg_contrib, and
utilization with pure cpu utilization as in how many cycles is spend on
a particular task. I called it "usage_util_avg" in my own patches, but
"util_avg" might be better if we agree that utilization == usage.

> > s/se->avg.usage_avg_contrib/se->avg.utilization_avg_contrib

util_avg_contrib maybe to keep it shorter.

> > s/__update_task_entity_usage/__update_task_entity_utilization
> > s/__update_entity_usage_avg_contrib/__update_entity_utilization_avg_contrib

Maybe use "util" here as well?

Morten
