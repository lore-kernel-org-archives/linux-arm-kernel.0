From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 27 Jan 2017 11:08:32 +0100
Subject: [PATCH v2] clk: samsung: mark s3c...._clk_sleep_init() as __init
In-Reply-To: <20170127002750.GC8801@codeaurora.org>
References: <1485293599-23581-1-git-send-email-martin@kaiser.cx>
 <1485380545-24815-1-git-send-email-martin@kaiser.cx>
 <CGME20170127003627epcas3p3dc6a50295e915679c346a6f32cc3c664@epcas3p3.samsung.com>
 <20170127002750.GC8801@codeaurora.org>
Message-ID: <2825cb23-0922-c950-f18f-7b9077831e33@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2017 01:27 AM, Stephen Boyd wrote:
> On 01/25, martin at kaiser.cx wrote:
>> From: Martin Kaiser <martin@kaiser.cx>
>>
>> These functions are referencing s3c...._clk_regs[], which are marked as
>> __initdata. When compiling with CONFIG_DEBUG_SECTION_MISMATCH=y, this
>> produces warnings like
>>
>> WARNING: vmlinux.o(.text+0x198350):
>> Section mismatch in reference from the function s3c2410_clk_sleep_init()
>> to the (unknown reference) .init.data:(unknown)
>>
>> Mark the s3c...._clk_sleep_init() functions as __init in
>> order to fix this.
>>
>> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
>
> Fixes tag?

The patch fixes the very first commit adding the driver:
"ca2e90a clk: samsung: add clock controller driver for s3c2412"
and it doesn't apply cleanly on top of that commit.
Still it applies cleanly up to v3.15 so I'll add the tag when
applying.

-- 
Thanks,
Sylwester
