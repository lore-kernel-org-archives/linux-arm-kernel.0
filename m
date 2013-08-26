From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 27 Aug 2013 01:04:25 +0530
Subject: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
In-Reply-To: <521B87C0.1090507@ti.com>
References: <1377287613-16491-1-git-send-email-joelf@ti.com>
 <521B3212.3050405@ti.com> <521B87C0.1090507@ti.com>
Message-ID: <521BADC1.7000003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 8/26/2013 10:22 PM, Joel Fernandes wrote:
> On 08/26/2013 05:46 AM, Sekhar Nori wrote:
>> On Saturday 24 August 2013 01:23 AM, Joel Fernandes wrote:
>>> HWMOD removal for MMC and Crypto is breaking edma_start as the events are
>>> being manually triggered due to unused channel list not being clear. Atleast
>>> breakage has been seen on these peripherals, but it is expected Audio (McASP)
>>> maybe breaking too.
>>>
>>> This patch fixes the issue, by reading the "dmas" property from the DT node if
>>> it exists and clearing the bits in the unused channel list so that these channels
>>> are not manually triggered.
>>>
>>> v2 changes:
>>> Reduced indendation by returning from if block.
>>
>> Is this a v2 or v3 since you already sent a v2 about a month back?
> 
> No, there aren't any changes since v2, I just resubmitted the same patch.

Heh, it does seem to contain some indentation changes per your
documentation :)

> 
>>>
>>> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>>> Reported-by: Balaji T K <balajitk@ti.com>
>>> Cc: Pantel Antoniou <panto@antoniou-consulting.com>
>>> Signed-off-by: Joel Fernandes <joelf@ti.com>
>>> ---
>>> Note:
>>> Patch should go in for -rc cycle as it fixes existing crypto drivers.
>>
>> We agreed the patch is not needed in -rc cycle since there are no
>> current EDMA users in DT-boot?
> 
> There is now, crypto and EDMA DT patches are being merged in.

They are being merged in v3.12, right? So you meant the -rc cycle of
v3.12? If yes, no need to wait for a broken v3.12-rc1 to come out. It is
possible to queue fixes during merge window too.

Thanks,
Sekhar
