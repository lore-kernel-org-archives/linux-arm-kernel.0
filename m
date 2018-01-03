From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 3 Jan 2018 14:29:34 +0000
Subject: [PATCH v5 7/9] arm64: Topology, rename cluster_id
In-Reply-To: <965127a6-816b-8e0c-d228-a3d73a8c643a@huawei.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-8-jeremy.linton@arm.com>
 <20171213180217.GB4060@red-moon>
 <7bb4e955-f3e5-d22f-4e78-eac97e66a9a6@arm.com>
 <20171218124229.GG507@e105550-lin.cambridge.arm.com>
 <965127a6-816b-8e0c-d228-a3d73a8c643a@huawei.com>
Message-ID: <20180103142934.GA5390@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/01/18 02:29, Xiongfeng Wang wrote:
> Hi,
> 
> On 2017/12/18 20:42, Morten Rasmussen wrote:
>> On Fri, Dec 15, 2017 at 10:36:35AM -0600, Jeremy Linton wrote:
>>> Hi,
>>>
>>> On 12/13/2017 12:02 PM, Lorenzo Pieralisi wrote:
>>>> [+Morten, Dietmar]
>>>>
>>>> $SUBJECT should be:
>>>>
>>>> arm64: topology: rename cluster_id
>>>
> [cut]
>>>
> I think we still need the information describing which cores are in one
> cluster. Many arm64 chips have the architecture core/cluster/socket. Cores
> in one cluster may share a same L2 cache. That information can be used to
> build the sched_domain. If we put cores in one cluster in one sched_domain,
> the performance will be better.(please see kernel/sched/topology.c:1197,
> cpu_coregroup_mask() uses 'core_sibling' to build a multi-core
> sched_domain).

We get all the cache information from DT/ACPI PPTT(mainly topology) and now
even the geometry. So ideally, the sharing information must come from that.
Any other solution might end up in conflict if DT/PPTT and that mismatch.

> So I think we still need variable to record which cores are in one
> sched_domain for future use.

I tend to say no, at-least not as is.
-- 
Regards,
Sudeep
