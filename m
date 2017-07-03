From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 3 Jul 2017 09:24:59 -0500
Subject: [PATCH] irqchip: gicv3-its: Use NUMA aware memory allocation for
 ITS tables
In-Reply-To: <ab7e26a8-5ab7-7c47-f19c-cb02fbd397b6@arm.com>
References: <1498405569-463-1-git-send-email-shankerd@codeaurora.org>
 <CAFpQJXU84OTEp-1BteQeSqNy3Ya2hDskZA=Th_0f47qtS9-ucw@mail.gmail.com>
 <CAFpQJXVh0ojzwqZmT5OgBArx9rpK0_yDw_+gyP8LAkT1e4HWrQ@mail.gmail.com>
 <ab7e26a8-5ab7-7c47-f19c-cb02fbd397b6@arm.com>
Message-ID: <ba64069e-f3a3-de85-df47-01008d7b3513@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 06/30/2017 03:51 AM, Marc Zyngier wrote:
> On 30/06/17 04:01, Ganapatrao Kulkarni wrote:
>> On Fri, Jun 30, 2017 at 8:04 AM, Ganapatrao Kulkarni
>> <gpkulkarni@gmail.com> wrote:
>>> Hi Shanker,
>>>
>>> On Sun, Jun 25, 2017 at 9:16 PM, Shanker Donthineni
>>> <shankerd@codeaurora.org> wrote:
>>>> The NUMA node information is visible to ITS driver but not being used
>>>> other than handling errata. This patch allocates the memory for ITS
>>>> tables from the corresponding NUMA node using the appropriate NUMA
>>>> aware functions.
>>
>> IMHO, the description would have been more constructive?
>>
>> "All ITS tables are mapped by default to NODE 0 memory.
>> Adding changes to allocate memory from respective NUMA NODES of ITS devices.
>> This will optimize tables access and avoids unnecessary inter-node traffic."
> 
> But more importantly, I'd like to see figures showing the actual benefit
> of this per-node allocation. Given that both of you guys have access to
> such platforms, please show me the numbers!
> 

I'll share the actual results which shows the improvement whenever 
available on our next chips. Current version of Qualcomm qdf2400 doesn't 
support multi socket configuration to capture results and share with you. 

Do you see any other issues with this patch apart from the performance 
improvements. I strongly believe this brings the noticeable improvement 
in numbers on systems where it has multi node memory/CPU configuration.


> Thanks,
> 
> 	M.
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
