From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Feb 2012 00:42:48 +0100
Subject: [PATCH v6 07/15] ARM: SoC: convert MSM SMP to SoC descriptor
In-Reply-To: <20120208233907.GA4416@codeaurora.org>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-8-git-send-email-marc.zyngier@arm.com>
 <20120208233907.GA4416@codeaurora.org>
Message-ID: <e69d03ae47b5981b2fa7c48d5987ea9a@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 8 Feb 2012 15:39:07 -0800, David Brown <davidb@codeaurora.org>
wrote:
> On Wed, Feb 08, 2012 at 12:30:51AM +0000, Marc Zyngier wrote:
> 
>> @@ -146,6 +152,9 @@ MACHINE_END
>>  #ifdef CONFIG_OF
>>  /* TODO: General device tree support for all MSM. */
>>  DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
>> +	.soc = &msm_soc_desc,
>> +	.fixup = msm8x60_fixup,
>> +	.reserve = msm8x60_reserve,
>>  	.map_io = msm8x60_map_io,
>>  	.init_irq = msm8x60_init_irq,
>>  	.init_machine = msm8x60_dt_init,
> 
> The fixup and reserve aren't really needed (and probably not wanted)
> for the DT board.  The fixup doesn't actually work, since it modifies
> the tags, which don't exist.  The reservation should be passed in the
> DT itself, since that has a mechanism for it.

Evidently a copy/paste abuse. I'll fix that shortly.

> Otherwise, the MSM part looks ok.
> 
> Acked-By: David Brown <davidb@codeaurora.org>

Thanks David.

        M.
-- 
Fast, cheap, reliable. Pick two.
