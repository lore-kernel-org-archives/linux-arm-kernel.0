From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 4 Jul 2018 13:52:13 +0100
Subject: [linux-sunxi] Re: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
Message-ID: <2ccf60d0-9ea0-0631-ca89-6e67426173f2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/07/18 19:42, Samuel Holland wrote:
> On 07/03/18 10:09, Marc Zyngier wrote:
>> On 11/05/18 03:27, Samuel Holland wrote:
>>> Hello,
>>>
>>> Several people (including me) have experienced extremely large system
>>> clock jumps on their A64-based devices, apparently due to the architectural
>>> timer going backward, which is interpreted by Linux as the timer wrapping
>>> around after 2^56 cycles.
>>>
>>> Investigation led to discovery of some obvious problems with this SoC's 
>>> architectural timer, and this patch series introduces what I believe is
>>> the simplest workaround. More details are in the commit message for patch
>>> 1. Patch 2 simply enables the workaround in the device tree.
>>
>> What's the deal with this series? There was a couple of nits to address, and 
>> I was more or less expecting a v2.
> 
> I got reports that people were still occasionally having clock jumps after
> applying this series, so I wanted to attempt a more complete fix, but I haven't
> had time to do any deeper investigation.

Looking at the FSL workaround, I see that they cover TVAL reads as well.
Not sure entirely why, but maybe it's worth to follow this lead?

Cheers,
Andre.

> I think this series is still beneficial
> even if it's not a complete solution, so I'll come back with another patch on
> top of this if/once I get it fully fixed.
> 
> I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
> timer) ? 150 should be a conservative iteration limit?
> 
> Also, does this make sense to CC to stable?
> 
> Thanks,
> Samuel
> 
