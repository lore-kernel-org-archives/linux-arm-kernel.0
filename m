From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Mon, 14 Jul 2014 18:54:11 +0100
Subject: [PATCH v3 09/12] Revert "sched: Put rq's sched_avg under
 CONFIG_FAIR_GROUP_SCHED"
In-Reply-To: <CAKfTPtCL6mta75k9eoK724wCm7S3w7E+psa1XDrxhN1YVDONPw@mail.gmail.com>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-10-git-send-email-vincent.guittot@linaro.org>
 <20140710131646.GB3935@laptop>
 <CAKfTPtDzxyrzVmX016VB8j_y19wcCBVB1Rj46FYngMA+Ajft6g@mail.gmail.com>
 <20140711151304.GD3935@laptop>
 <CAKfTPtCL6mta75k9eoK724wCm7S3w7E+psa1XDrxhN1YVDONPw@mail.gmail.com>
Message-ID: <53C41943.2000601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> In that same discussion ISTR a suggestion about adding avg_running time,
>> as opposed to the current avg_runnable. The sum of avg_running should be
>> much more accurate, and still react correctly to migrations.
> 
> I haven't look in details but I agree that avg_running would be much
> more accurate than avg_runnable and should probably fit the
> requirement. Does it means that we could re-add the avg_running (or
> something similar) that has disappeared during the review of load avg
> tracking patchset ?

Are you referring to '[RFC PATCH 14/14] sched: implement usage tracking'
https://lkml.org/lkml/2012/2/1/769 from Paul Turner?

__update_entity_runnable_avg() has an additional parameter 'running' so
that it can be called for

a) sched_entities in update_entity_load_avg():

  __update_entity_runnable_avg(..., se->on_rq, cfs_rq->curr == se))


b) rq's in update_rq_runnable_avg():

  __update_entity_runnable_avg(..., runnable, runnable);

I can see how it gives us two different signals for a sched_entity but
for a rq?

Do I miss something here?

-- Dietmar

[...]
