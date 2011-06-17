From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 17 Jun 2011 19:35:59 +0400
Subject: [PATCH] collie: don't read GPSR
In-Reply-To: <BANLkTikgNuovqVax-KdYjx1FM3kGCH4dDQ@mail.gmail.com>
References: <1308319892-13057-1-git-send-email-dbaryshkov@gmail.com>
	<BANLkTikgNuovqVax-KdYjx1FM3kGCH4dDQ@mail.gmail.com>
Message-ID: <BANLkTi=RPmwqzBvr_TYbPmd0s1-BM9unKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/17/11, Eric Miao <eric.y.miao@gmail.com> wrote:
> Would it be better to switch to use gpio_* API instead of manipulating
> GPxR directly?

Yes. Probably. But this would require a much bigger cleanup effort. Waiting
for spare time for it.

> On Fri, Jun 17, 2011 at 10:11 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> On StrongARM GPSR is write-only according to docs, so don't read from
>> it. Just set the required GPIO.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  arch/arm/mach-sa1100/collie.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
>> index f28025e..3f32ba2 100644
>> --- a/arch/arm/mach-sa1100/collie.c
>> +++ b/arch/arm/mach-sa1100/collie.c
>> @@ -339,7 +339,7 @@ static void __init collie_init(void)
>>
>>        PCFR = PCFR_OPDE;
>>
>> -       GPSR |= _COLLIE_GPIO_UCB1x00_RESET;
>> +       GPSR = _COLLIE_GPIO_UCB1x00_RESET;
>>
>>
>>        platform_scoop_config = &collie_pcmcia_config;
>> --
>> 1.7.5.3
>>
>>
>


-- 
With best wishes
Dmitry
