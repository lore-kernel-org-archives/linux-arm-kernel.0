From: shuah@kernel.org (Shuah Khan)
Date: Mon, 10 Sep 2018 20:02:05 -0600
Subject: [PATCH] arm64: add NUMA emulation support
In-Reply-To: <20180910134845.GH10951@dhcp22.suse.cz>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
 <20180829110802.GD10349@dhcp22.suse.cz>
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
 <20180905064252.GW14951@dhcp22.suse.cz>
 <c1b58f13-6190-20e9-7e4f-b8bc2b9d5f80@kernel.org>
 <20180907083452.GC19621@dhcp22.suse.cz>
 <e46e715c-f115-f054-eeb2-3cecbcd1192d@kernel.org>
 <20180910134845.GH10951@dhcp22.suse.cz>
Message-ID: <4d7beb50-f778-507a-4c3c-f6de92f8cfb9@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On 09/10/2018 07:48 AM, Michal Hocko wrote:
> On Fri 07-09-18 16:30:59, Shuah Khan wrote:
>> On 09/07/2018 02:34 AM, Michal Hocko wrote:
>>> On Thu 06-09-18 15:53:34, Shuah Khan wrote:
[....]
>>
>> In addition to isolation, being able to reserve a block instead is one of the
>> issues I am looking to address. Unfortunately memory cgroups won't address that
>> issue.
> 
> Could you be more specific why you need reservations other than
> isolation.
> 

Taking automotive as a specific example, there are two classes of applications:
1. critical applications that must run
2. Infotainment and misc. user-space.

In this case, being able to reserve a block of memory for critical applications
will ensure the memory is available for them. If a critical application has to
restart and/or when an on-demand critical application starts, it might not be able
to allocate memory if it is not reserved.

When a flat system has multiple memory blocks, with NUMA emulation in conjunction with
cpusets, one or more block can be reserved for critical applications configuring a set
of cpus and one of more memory nodes for them.

Memory cgroups will not support such reservation. Hope this helps explain the use-case
I am trying to address with this patch.

thanks,
-- Shuah
