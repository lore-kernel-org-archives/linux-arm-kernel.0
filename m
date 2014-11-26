From: gaku.inami.xw@bp.renesas.com (Gaku Inami)
Date: Wed, 26 Nov 2014 10:25:54 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7790 CCI configuration
In-Reply-To: <5474543A.807@arm.com>
References: <54743D0F.5080307@bp.renesas.com> <5474543A.807@arm.com>
Message-ID: <54752C22.7010806@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

(2014/11/25 19:04), Sudeep Holla wrote:
>
>
> On 25/11/14 08:25, Gaku Inami wrote:
>> Add the settings of CCI-400 for enabling ca15/ca7 snoop on r8a7790.
>> Needed to configure the CCI boot cluster port regardless of MCPM.
>>
>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>
>> Changes since version 1:
>> - Fix a way to wait for the register read.
>>
>>   arch/arm/mach-shmobile/smp-r8a7790.c |   19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
>> index 9c3da13..b65d908 100644
>> --- a/arch/arm/mach-shmobile/smp-r8a7790.c
>> +++ b/arch/arm/mach-shmobile/smp-r8a7790.c
>> @@ -25,6 +25,12 @@
>>   #include "pm-rcar.h"
>>   #include "r8a7790.h"
>>
>> +#define CCI_BASE    0xf0090000
>> +#define CCI_SLAVE3    0x4000
>> +#define CCI_SLAVE4    0x5000
>> +#define CCI_SNOOP    0x0000
>> +#define CCI_STATUS    0x000c
>> +
>
> I have asked the same question multiple times in the past, why are you
> not using the DT bindings and the CCI driver for this ? Why are you
> duplicating the code ? Any limitations to use them ?
>
Thank you for your feedback.
I will consider to use the DT bindings and the CCI driver.

Regards,
Inami

> Regards,
> Sudeep
>
