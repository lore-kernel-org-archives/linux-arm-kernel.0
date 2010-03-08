From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 8 Mar 2010 20:10:18 +0800
Subject: [PATCH] pxa: fix for UART reference in section text for a number
	of platforms.
In-Reply-To: <f17812d71003080348k7ff5cd77lf5e1262ce1ccf14@mail.gmail.com>
References: <4B94DC52.1040201@cam.ac.uk>
	<f17812d71003080348k7ff5cd77lf5e1262ce1ccf14@mail.gmail.com>
Message-ID: <f17812d71003080410y7d5dad83t28e6855aa4ad5cfc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 8, 2010 at 7:48 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> What's the background?
>

OK, I saw the thread. So this is basically going to move the "UART" to
bss, which doesn't get discarded. However, my 'devel' branch has been
modified a bit to support off chip UART decompressing messages to be
displayed, I'm afraid this needs to be updated a bit.

Thanks

> 2010/3/8 Jonathan Cameron <jic23@cam.ac.uk>:
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> ---
>> ?Fix exactly as proposed by Russell King. ?Thanks!
>>
>> ?arch/arm/mach-pxa/include/mach/uncompress.h | ? ?4 +++-
>> ?1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
>> index 237734b..b009299 100644
>> --- a/arch/arm/mach-pxa/include/mach/uncompress.h
>> +++ b/arch/arm/mach-pxa/include/mach/uncompress.h
>> @@ -15,7 +15,7 @@
>>
>> ?#define __REG(x) ? ? ? ((volatile unsigned long *)x)
>>
>> -static volatile unsigned long *UART = FFUART;
>> +static volatile unsigned long *UART;
>>
>> ?static inline void putc(char c)
>> ?{
>> @@ -39,6 +39,8 @@ static inline void arch_decomp_setup(void)
>> ? ? ? ? ? ?|| machine_is_csb726() || machine_is_stargate2()
>> ? ? ? ? ? ?|| machine_is_cm_x300() || machine_is_balloon3())
>> ? ? ? ? ? ? ? ?UART = STUART;
>> + ? ? ? else
>> + ? ? ? ? ? ? ? UART = FFUART;
>> ?}
>>
>> ?/*
>> --
>> 1.6.4.4
>>
>>
>
