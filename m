From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 16 Aug 2017 22:52:43 +0200
Subject: [PATCH v3 3/5] reset: stm32: use the reset-simple driver
In-Reply-To: <edbdf06c-fb1e-63f1-d6b2-17193c86385a@adaptrum.com>
References: <20170816094701.30678-1-p.zabel@pengutronix.de>
 <20170816094701.30678-4-p.zabel@pengutronix.de>
 <edbdf06c-fb1e-63f1-d6b2-17193c86385a@adaptrum.com>
Message-ID: <338608e8-9e83-fc0f-8d8a-18a336e94860@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 16.08.2017 um 22:50 schrieb Alexandru Gagniuc:
> On 08/16/2017 02:46 AM, Philipp Zabel wrote:
>> The reset-simple driver can be used without changes.
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Reviewed-by: Alexandru Gagniuc <alex.g@adaptrum.com>
> 
>> ---
>>  drivers/reset/Kconfig        |  11 ++---
>>  drivers/reset/Makefile       |   1 -
>>  drivers/reset/reset-simple.c |   1 +
>>  drivers/reset/reset-stm32.c  | 108
>> -------------------------------------------
>>  4 files changed, 4 insertions(+), 117 deletions(-)
>>  delete mode 100644 drivers/reset/reset-stm32.c
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 78a8f6057985b..29f4487c290fc 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -70,19 +70,14 @@ config RESET_PISTACHIO
>>
>>  config RESET_SIMPLE
>>      bool "Simple Reset Controller Driver" if COMPILE_TEST
>> -    default ARCH_SOCFPGA || ARCH_SUNXI
>> +    default ARCH_SOCFPGA || ARCH_STM32 || ARCH_SUNXI
> 
> If this series gets respun, could you please look into removing the
> ARCH_ dependency here?

Why? It's not a dependency, just the default. Doing it here decouples it
from having to do Kconfig changes in the arm-soc tree as well.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
