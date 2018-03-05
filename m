From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 05 Mar 2018 14:02:12 -0800
Subject: [PATCH v2] perf/core: Add support for PMUs that can be read from
 more than 1 CPU
In-Reply-To: <20180305122140.wwwu4hvhssouuzcp@lakrids.cambridge.arm.com>
References: <1520039693-30914-1-git-send-email-skannan@codeaurora.org>
 <20180305121702.l64rzrckog6d7jop@lakrids.cambridge.arm.com>
 <20180305122140.wwwu4hvhssouuzcp@lakrids.cambridge.arm.com>
Message-ID: <5A9DBE64.3060209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2018 04:21 AM, Mark Rutland wrote:
> On Mon, Mar 05, 2018 at 12:17:02PM +0000, Mark Rutland wrote:
>> On Fri, Mar 02, 2018 at 05:14:53PM -0800, Saravana Kannan wrote:
>
>>> @@ -629,6 +629,7 @@ struct perf_event {
>>>
>>>   	int				oncpu;
>>>   	int				cpu;
>>> +	cpumask_t			readable_on_cpus;
>>
>> For most PMUs, this will be emptry, and it's potentially *very* large
>> (e.g. on systems where NR_CPUS is 4096). Please use a poitner to a mask,
>> as I suggested in [1], e.g.
>
>> [1] https://lkml.kernel.org/r/20171128124534.3jvuala525wvn64r at wfg-t540p.sh.intel.com
>
> Whoops, that should've been:
>
> [1] https://lkml.kernel.org/r/20180225143802.denbkubqjg2dc7af at salmiak
>

I didn't notice you mentioned the use of pointers, but I was planning on 
doing that anyway. But then I realize people will complain about 
cacheline bouncing across 4096 CPUs if I use a cpu mask pointer.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
