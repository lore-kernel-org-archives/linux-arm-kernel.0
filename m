From: shuah@kernel.org (Shuah Khan)
Date: Fri, 7 Sep 2018 16:30:59 -0600
Subject: [PATCH] arm64: add NUMA emulation support
In-Reply-To: <20180907083452.GC19621@dhcp22.suse.cz>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
 <20180829110802.GD10349@dhcp22.suse.cz>
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
 <20180905064252.GW14951@dhcp22.suse.cz>
 <c1b58f13-6190-20e9-7e4f-b8bc2b9d5f80@kernel.org>
 <20180907083452.GC19621@dhcp22.suse.cz>
Message-ID: <e46e715c-f115-f054-eeb2-3cecbcd1192d@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2018 02:34 AM, Michal Hocko wrote:
> On Thu 06-09-18 15:53:34, Shuah Khan wrote:
> [...]
>> A few critical allocations could be satisfied and root cgroup prevails. It is not the
>> intent to have exclusivity at the expense of the kernel.
> 
> Well, it is not "few critical allocations". It can be a lot of
> memory. Basically any GFP_KERNEL allocation. So how exactly you expect
> this to work when you cannot estimate how much
> memory will kernel eat?
> 
>>
>> This feature will allow a way to configure cpusets on non-NUMA for workloads that can
>> benefit from the reservation and isolation that is available within the constraints of
>> exclusive cpuset policies.
> 
> AFAIR this was the first approach Google took for the memory isolation
> and they moved over to memory cgroups. 

In addition to isolation, being able to reserve a block instead is one of the
issues I am looking to address. Unfortunately memory cgroups won't address that
issue.

I would recommend to talk to
> those guys bebfore you introduce potentially a lot of code that will not
> really work for the workload you indend it for.
> 

Will you be able to point me to a good contact at Goggle and/or some pointers
on finding discussion on the memory isolation. My searches on lkml came up
short,

thanks,
-- Shuah
