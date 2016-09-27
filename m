From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 27 Sep 2016 14:26:08 +0800
Subject: [PATCH] arm64, numa: Add cpu_to_node() implementation.
In-Reply-To: <20160920132120.GQ25086@rric.localdomain>
References: <1474310970-21264-1-git-send-email-ddaney.cavm@gmail.com>
 <20160920104348.GP25086@rric.localdomain> <57E11E52.8060303@linaro.org>
 <20160920132120.GQ25086@rric.localdomain>
Message-ID: <57EA1100.2080900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2016 09:21 PM, Robert Richter wrote:
> On 20.09.16 19:32:34, Hanjun Guo wrote:
>> On 09/20/2016 06:43 PM, Robert Richter wrote:
>
>>> Unfortunately either your nor my code does fix the BUG_ON() I see with
>>> the numa kernel:
>>>
>>>   kernel BUG at mm/page_alloc.c:1848!
>>>
>>> See below for the core dump. It looks like this happens due to moving
>>> a mem block where first and last page are mapped to different numa
>>> nodes, thus, triggering the BUG_ON().
>>
>> Didn't triggered it on our NUMA hardware, could you provide your
>> config then we can have a try?
>
> Config attached. Other configs with an initrd fail too.

hmm, we can't reproduce it on our hardware, do we need
to run some specific stress test on it?

Thanks
Hanjun
