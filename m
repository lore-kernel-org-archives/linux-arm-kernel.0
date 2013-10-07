From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 07 Oct 2013 18:06:33 +0200
Subject: [PATCH v3 04/19] clk: at91: add PMC macro file for dt definitions
In-Reply-To: <5252D0A5.60304@atmel.com>
References: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
 <1375938270-3965-1-git-send-email-b.brezillon@overkiz.com>
 <5252D0A5.60304@atmel.com>
Message-ID: <5252DC09.6010207@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2013 17:17, Nicolas Ferre wrote:
> On 08/08/2013 07:04, Boris BREZILLON :
>> This patch adds a new macro file for PMC macros.
>>
>> This macro file includes the definitions of SR (status register) bit
>> offsets and will be use to reference PMC irqs.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> ---
>>   include/dt-bindings/clk/at91/common/pmc.h |   20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>   create mode 100644 include/dt-bindings/clk/at91/common/pmc.h
>>
>> diff --git a/include/dt-bindings/clk/at91/common/pmc.h 
>> b/include/dt-bindings/clk/at91/common/pmc.h
>> new file mode 100644
>> index 0000000..edc51d6
>> --- /dev/null
>> +++ b/include/dt-bindings/clk/at91/common/pmc.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * This header provides constants for AT91 pmc status.
>> + *
>> + * The constants defined in this header are being used in dts.
>
> It is better to add one line about license: for example:
>
>  * Licensed under GPLv2 or later.
>
>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_AT91_PMC_H
>> +#define _DT_BINDINGS_CLK_AT91_PMC_H
>> +
>> +#define AT91_PMC_MOSCS        0        /* MOSCS Flag */
>> +#define AT91_PMC_LOCKA        1        /* PLLA Lock */
>> +#define AT91_PMC_LOCKB        2        /* PLLB Lock */
>> +#define AT91_PMC_MCKRDY        3        /* Master Clock */
>> +#define AT91_PMC_LOCKU        6        /* UPLL Lock */
>> +#define AT91_PMC_PCKRDY(id)    (8 + id)    /* Programmable Clock */
>
> I prefer with parenthesis around "id" (8 + (id))

Absolutely, I'll fix it.
>
>> +#define AT91_PMC_MOSCSELS    16        /* Main Oscillator Selection */
>> +#define AT91_PMC_MOSCRCS    17        /* Main On-Chip RC */
>> +#define AT91_PMC_CFDEV        18        /* Clock Failure Detector 
>> Event */
>> +
>> +#endif
>>
>
>
