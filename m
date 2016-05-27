From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Fri, 27 May 2016 10:35:51 +0800
Subject: [PATCH 3/3] arm64/numa: fix type info
In-Reply-To: <57472E8C.1050607@gmail.com>
References: <1464230639-9852-1-git-send-email-thunder.leizhen@huawei.com>
 <1464230639-9852-3-git-send-email-thunder.leizhen@huawei.com>
 <CAFpQJXWih2V9Ki-vkL+cDni=VoWL0nA-fx5B5XtfNxFsoUso-g@mail.gmail.com>
 <1464280503.16344.40.camel@perches.com> <57472E8C.1050607@gmail.com>
Message-ID: <5747B287.7050309@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/5/27 1:12, David Daney wrote:
> The current patch to correct this problem is here:
> 
> https://lkml.org/lkml/2016/5/24/679
> 
> Since v7 of the ACPI/NUMA patches are likely going to be added to linux-next as soon as the current merge window ends, further simplifications of the informational prints should probably be rebased on top of it.
> 
> David Daney
> 

>> On Thu, 2016-05-26 at 09:22 -0700, Ganapatrao Kulkarni wrote:
>>> IIRC, it should be
>>> if (!numa_off)
>>> we want to print this message when we failed to find proper numa configuration.
>>> when numa_off is set, we will not look for any numa configuration.
>>>
>>>>
>>>> +               pr_info("%s\n", "No NUMA configuration found");
>>


OK, I think I also missed some cases.

But my problem still have not been resolved by "https://lkml.org/lkml/2016/5/24/679", see below. I will update my patches base on it.


[    0.000000] NUMA: Adding memblock [0x0 - 0x6affffff] on node 0
[    0.000000] NUMA: parsing numa-distance-map-v1
[    0.000000] NUMA: Warning: invalid memblk node 4 [mem 0x6b000000-0x7fbfffff]		//My numa configuration is incorrect, but not "No ... found"
[    0.000000] No NUMA configuration found						//Above warning is very detail, this can be removed
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000017ffffffff]
