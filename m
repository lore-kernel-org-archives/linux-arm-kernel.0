From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 11 Sep 2014 16:04:44 +0200
Subject: [PATCH v5 10/12] sched: get CPU's utilization statistic
In-Reply-To: <CAKfTPtBbjpCFifoyFSh8Hb3nBZFFTjjxdfxnpMk=CHy5aX1qpg@mail.gmail.com>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-11-git-send-email-vincent.guittot@linaro.org>
 <20140911123412.GY3190@worktop.ger.corp.intel.com>
 <CAKfTPtBbjpCFifoyFSh8Hb3nBZFFTjjxdfxnpMk=CHy5aX1qpg@mail.gmail.com>
Message-ID: <20140911140444.GH4783@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 03:07:52PM +0200, Vincent Guittot wrote:
> > Also I'm not entirely sure I like the usage, utilization names/metrics.
> > I would suggest to reverse them. Call the pure running number
> > 'utilization' and this scaled with capacity 'usage' or so.
> 
> ok. i can invert 'usage' and 'utilization', which will give
> 
> s/get_cpu_utilization/get_cpu_usage/
> s/sgs->group_utilization/sgs->group_usage/
> s/cfs.usage_load_avg/cfs.utilization_load_avg/
> s/se->avg.usage_avg_contrib/se->avg.utilization_avg_contrib
> s/__update_task_entity_usage/__update_task_entity_utilization
> s/__update_entity_usage_avg_contrib/__update_entity_utilization_avg_contrib
> 

Any other opinions before Vince goes and applies sed on patches? ;-)
