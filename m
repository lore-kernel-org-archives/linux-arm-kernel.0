From: qais.yousef@arm.com (Qais Yousef)
Date: Tue, 24 Jul 2018 09:59:21 +0100
Subject: [PATCH 1/4] sched/topology: SD_ASYM_CPUCAPACITY flag detection
In-Reply-To: <20180724083710.GB29978@e105550-lin.cambridge.arm.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
 <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
 <dbd8deec-a79d-5697-0c50-ea1a9ab7e5c9@arm.com>
 <20180723152551.GA29978@e105550-lin.cambridge.arm.com>
 <b75f665f-7d60-5d83-eaf6-88c534afe254@arm.com>
 <20180724083710.GB29978@e105550-lin.cambridge.arm.com>
Message-ID: <0d9598fa-28c1-0851-4d40-2cc97a5317b5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/18 09:37, Morten Rasmussen wrote:
> On Mon, Jul 23, 2018 at 05:07:50PM +0100, Qais Yousef wrote:
>> On 23/07/18 16:27, Morten Rasmussen wrote:
>>> It does increase the cost of things like hotplug slightly and
>>> repartitioning of root_domains a slightly but I don't see how we can
>>> avoid it if we want generic code to set this flag. If the costs are not
>>> acceptable I think the only option is to make the detection architecture
>>> specific.
>> I think hotplug is already expensive and this overhead would be small in
>> comparison. But this could be called when frequency changes if I understood
>> correctly - this is the one I wasn't sure how 'hot' it could be. I wouldn't
>> expect frequency changes at a very high rate because it's relatively
>> expensive too..
> A frequency change shouldn't lead to a flag change or a rebuild of the
> sched_domain hierarhcy. The situations where the hierarchy should be
> rebuild to update the flag is during boot as we only know the amount of
> asymmetry once cpufreq has been initialized, when cpus are hotplugged
> in/out, and when root_domains change due to cpuset reconfiguration. So
> it should be a relatively rare event.


Ah OK I misunderstood that part then.

The series LGTM then.

-- 
Qais Yousef
