From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 08 Sep 2014 12:03:59 +0100
Subject: [PATCH v2 4/5] arm64: Introduce dummy version of asm/fiq.h
In-Reply-To: <20140905165033.GD10976@arm.com>
References: <1409846620-14542-1-git-send-email-daniel.thompson@linaro.org>
 <1409931198-22600-1-git-send-email-daniel.thompson@linaro.org>
 <1409931198-22600-5-git-send-email-daniel.thompson@linaro.org>
 <20140905165033.GD10976@arm.com>
Message-ID: <540D8D1F.5000804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/14 17:50, Catalin Marinas wrote:
> On Fri, Sep 05, 2014 at 04:33:17PM +0100, Daniel Thompson wrote:
>> Drivers that are shared between arm and arm64 and which employ
>> FIQ on arm cannot include asm/fiq.h without #ifdef'ing. This patch
>> introduces a dummy version of asm/fiq.h to arm64 to avoid this.
>>
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm64/include/asm/fiq.h | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>  create mode 100644 arch/arm64/include/asm/fiq.h
>>
>> diff --git a/arch/arm64/include/asm/fiq.h b/arch/arm64/include/asm/fiq.h
>> new file mode 100644
>> index 0000000..909ec54
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/fiq.h
>> @@ -0,0 +1,18 @@
>> +/*
>> + * arch/arm64/include/asm/fiq.h
>> + *
>> + * Placeholder to reduce #ifdef'ing in shared arm/arm64 drivers.
>> + */
>> +
>> +#ifndef __ASM_FIQ_H
>> +#define __ASM_FIQ_H
>> +
>> +/*
>> + * This placeholder allows code of the following form to be simplified:
>> + *
>> + * #ifdef CONFIG_FIQ
>> + * #include <asm/fiq.h>
>> + * #endif
>> + */
>> +
>> +#endif
> 
> OK, we add a dummy file, but please keep it simple. Comments are fine
> but no need for header guards (nor the file name, on arm64 we try to get
> rid of them, though some still slip through).

Ok. I'll fix this.
