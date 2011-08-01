From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 01 Aug 2011 09:20:55 +0100
Subject: [RFC PATCH v9 0/4] Consolidating GIC per-cpu interrupts
In-Reply-To: <4E3102F0.4030705@codeaurora.org>
References: <1311267448-14652-1-git-send-email-marc.zyngier@arm.com>
	<4E3102F0.4030705@codeaurora.org>
Message-ID: <4E3661E7.2000003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/07/11 07:34, Stephen Boyd wrote:
> On 07/21/2011 09:57 AM, Marc Zyngier wrote:
>> The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
>> problems:
>>
> [snip]
>>
>> Patches against next-20110721, tested on PB11MP. As this patch series
>> is quite different from the previous one, I've dropped all previous
>> acks from platform maintainers.
> 
> I tried this out the other day and it didn't work. The setup_irq() calls
> in msm timer code fails and then we calibrate delay forever. I haven't
> looked further.

Ah, of course. Need to do a gic_request_ppi() on CPU0's timer instead of
request_irq(), but only on msm8x60/msm8960. Not very nice.

I'll update the patches and repost them later today.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
