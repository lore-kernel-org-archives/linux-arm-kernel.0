From: yuyang.du@intel.com (Yuyang Du)
Date: Fri, 18 Jul 2014 09:27:52 +0800
Subject: [PATCH v3 09/12] Revert "sched: Put rq's sched_avg under
 CONFIG_FAIR_GROUP_SCHED"
In-Reply-To: <53C41943.2000601@arm.com>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-10-git-send-email-vincent.guittot@linaro.org>
 <20140710131646.GB3935@laptop>
 <CAKfTPtDzxyrzVmX016VB8j_y19wcCBVB1Rj46FYngMA+Ajft6g@mail.gmail.com>
 <20140711151304.GD3935@laptop>
 <CAKfTPtCL6mta75k9eoK724wCm7S3w7E+psa1XDrxhN1YVDONPw@mail.gmail.com>
 <53C41943.2000601@arm.com>
Message-ID: <20140718012752.GE2901@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 06:54:11PM +0100, Dietmar Eggemann wrote:
> __update_entity_runnable_avg() has an additional parameter 'running' so
> that it can be called for
> 
> a) sched_entities in update_entity_load_avg():
> 
>   __update_entity_runnable_avg(..., se->on_rq, cfs_rq->curr == se))
> 
> 
> b) rq's in update_rq_runnable_avg():
> 
>   __update_entity_runnable_avg(..., runnable, runnable);
> 
> I can see how it gives us two different signals for a sched_entity but
> for a rq?
> 
For rq, 

__update_entity_runnable_avg(..., runnable, runnable > 0)

Then, first one would be effectively CPU ConCurrency (fair and !fair) and
second one would be CPU (has task) running (or about CPU utilization for
fair and !fair), :)

Thanks,
Yuyang
