From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 11 Jul 2013 17:45:55 +0200
Subject: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
In-Reply-To: <20130711145916.GA6138@kahuna>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
 <20130711145916.GA6138@kahuna>
Message-ID: <51DED333.9080609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2013 04:59 PM, Nishanth Menon wrote:
> On 16:23-20130711, Peter Ujfalusi wrote:
>> OMAP4 no longer boots in legacy mode so the code here is no longer used.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  arch/arm/mach-omap2/twl-common.c | 332 ++-------------------------------------
>>  arch/arm/mach-omap2/twl-common.h |   8 -
>>  2 files changed, 12 insertions(+), 328 deletions(-)
> Could we modify the Makefile and build twl-common.o only for
> CONFIG_ARCH_OMAP3?
> 
> We could get rid of all the #ifdef from the code that way. OMAP3 is the
> only platform that still depends on this - Further, with this change,

Yep, I can do that. I'll send a separate patch to do this.

> commit 34a38440689b06a515104d668494e0ff8a4e1537
> (regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators)
> will need a relook as well. currently part of the discussion with Mark
> in [1]
> 
> [1] http://marc.info/?t=137185016300003&r=1&w=2

I don't see anything touching twl-common.c/h in the series.
But at the end we should get rid of the legacy support in all of the drivers
aimed for OMAP4+ gradually since it is pointless to keep dead code. Emphasis
on gradually ;)

-- 
P?ter
