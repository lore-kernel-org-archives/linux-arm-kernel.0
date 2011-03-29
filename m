From: madhavi.linux@gmail.com (Madhavi Manchala)
Date: Tue, 29 Mar 2011 15:08:10 +0530
Subject: MACH_TYPE undeclared error
In-Reply-To: <20110329092421.GJ30938@pengutronix.de>
References: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
	<20110329065457.GG30938@pengutronix.de>
	<AANLkTimsNOmK4H8MYMB2jjd+zkT4qcYD1dy+J1fxdd7w@mail.gmail.com>
	<20110329092421.GJ30938@pengutronix.de>
Message-ID: <AANLkTi=Aha4R_tCdMC8ucp76yh3MD1ORayik7WmgfEiX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Uwe,

2011/3/29 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Tue, Mar 29, 2011 at 02:01:10PM +0530, Madhavi Manchala wrote:
>> 2011/3/29 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> > On Tue, Mar 29, 2011 at 12:01:40PM +0530, Madhavi Manchala wrote:
>> >> I have defined a MACHINE_START macro in my board C file as follows.
>> >>
>> >> MACHINE_START(S3C2510, "S3C2510")
>> >> ? ? ? .init_irq ? ? ? = s3c2510_init_irq,
>> >> ? ? ? .timer ? ? ? ? ?= &s3c2510_time_init,
>> >> MACHINE_END
>> >>
>> >> When I try to compile this C file, I am seeing the following error message.
>> >>
>> >> arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
>> >> undeclared here (not in a function)
>> > you need a line defining S3C2510 in arch/arm/tools/mach-types.
>>
>> Yeah. It is there in the arch/arm/tools/mach-types file. I did not add
>> to it, but it is automatically generated. The few lines from the
>> arch/arm/tools/mach-types file are as follows.
>>
>> izarus ? ? ? ? ? ? ? ?MACH_IZARUS ? ? ? ? ? ? IZARUS ? ? ? ? ?573
>> pxa_rts ? ? ? ? ? ? ? MACH_RTS ? ? ? ? ? ? ? ?RTS ? ? ? ? ? ? ? ? ? ? 574
>> se5100 ? ? ? ? ? ? ? ?MACH_SE5100 ? ? ? ? ? ? SE5100 ? ? ? ? ?575
>> s3c2510 ? ? ? ? ? ? ? MACH_S3C2510 ? ?S3C2510 ? ? ? ? 576
>> csb437tl ? ? ? ? ? ? ?MACH_CSB437TL ? CSB437TL ? ? ? ? ? ? ? ?577
>> slauson ? ? ? ? ? ? ? MACH_SLAUSON ? ?SLAUSON ? ? ? ? 578
>> pearlriver ? ? ? ? ? ?MACH_PEARLRIVER PEARLRIVER ? ? ?579
>> tdc_p210 ? ? ? ? ? ? ?MACH_TDC_P210 ? TDC_P210 ? ? ? ?580
>>
>> The machine S3C2510 is there in that file.
> Do you have
>
> ? ? ? ?#include <asm/mach-types.h>
>
> in your machine file?

It is not included in my machine file, previously. Now I included it
in my machine file and I am able to compile the file without any
issues.

Thanks for your valuable information.

Thanks and Regards,
Madhavi M.

> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
