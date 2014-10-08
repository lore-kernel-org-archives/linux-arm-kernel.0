From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 8 Oct 2014 09:16:09 +0200
Subject: [PATCH 4/7] sched: Track group sched_entity usage contributions
In-Reply-To: <xm26oatnk55g.fsf@sword-of-the-dawn.mtv.corp.google.com>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-5-git-send-email-vincent.guittot@linaro.org>
 <xm26oatnk55g.fsf@sword-of-the-dawn.mtv.corp.google.com>
Message-ID: <CAKfTPtC5qf=zC-SP8dRV+o_KJoh8zgSSX=07D3r0MB6n2BgfFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 October 2014 22:15,  <bsegall@google.com> wrote:
> Vincent Guittot <vincent.guittot@linaro.org> writes:
>
>> From: Morten Rasmussen <morten.rasmussen@arm.com>
>>
>> Adds usage contribution tracking for group entities. Unlike
>> se->avg.load_avg_contrib, se->avg.utilization_avg_contrib for group
>> entities is the sum of se->avg.utilization_avg_contrib for all entities on the
>> group runqueue. It is _not_ influenced in any way by the task group
>> h_load. Hence it is representing the actual cpu usage of the group, not
>> its intended load contribution which may differ significantly from the
>> utilization on lightly utilized systems.
>
>
> Just noting that this version also has usage disappear immediately when
> a task blocks, although it does what you probably want on migration.

Yes. For this patchset, we prefer to stay aligned with current
implementation which only take into account runnable tasks in order
cap the change of the behavior.

IMHO, the use of blocked task in utilization_avg_contrib should be
part of a dedicated patchset with dedicated non regression test

>
> Also, group-ses don't ever use their running_avg_sum so it's kinda a
> waste, but I'm not sure it's worth doing anything about.
>
>>
