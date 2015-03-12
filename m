From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 12 Mar 2015 22:05:24 +0100
Subject: [PATCH v2 07/18] drivers: reset: Add STM32 reset driver
In-Reply-To: <1426079308.3101.57.camel@pengutronix.de>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <2383270.cAJPOxrkvo@wuerfel>
 <CALszF6D3XMkjkMTdS-1xnVMFzgAW53NNOKOsfztsCboTdsBaaw@mail.gmail.com>
 <2455342.zT71E5iyaL@wuerfel>
 <CALszF6DENRS2L8mHD_iPsPwbAZndbHoB10oHaJ8-E4ajhog=8w@mail.gmail.com>
 <1426079308.3101.57.camel@pengutronix.de>
Message-ID: <CALszF6DOtAKLwo=VVYVKRZuhWC_NNvwKrV9R6_GYPdrRqh_0Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-11 14:08 GMT+01:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Dienstag, den 10.03.2015, 22:20 +0100 schrieb Maxime Coquelin:
>> 2015-03-10 21:21 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
>> > On Tuesday 10 March 2015 16:44:24 Maxime Coquelin wrote:
>> >> 2015-03-10 16:02 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
>> >> > On Friday 20 February 2015 19:01:06 Maxime Coquelin wrote:
>> >> >> +/* AHB1 */
>> >> >> +#define GPIOA_RESET    0
>> >> >> +#define GPIOB_RESET    1
>> >> >> +#define GPIOC_RESET    2
>> >> >> +#define GPIOD_RESET    3
>> >> >> +#define GPIOE_RESET    4
>> >> >> +#define GPIOF_RESET    5
>> >> >> +#define GPIOG_RESET    6
>> >> >> +#define GPIOH_RESET    7
>> >> >> +#define GPIOI_RESET    8
>> >> >> +#define GPIOJ_RESET    9
>> >> >> +#define GPIOK_RESET    10
>> >> >>
>> >> >
>> >> > As these are just the hardware numbers, it's better to not make them
>> >> > part of the binding at all. Instead, just document in the binding that
>> >> > one is supposed to pass the hardware number as the argument.
>> >>
>> >> The reset controller is part of the RCC (Reset & Clock Controller) IP.
>> >> In this version, I only provided the reset registers to the reset
>> >> controller driver, but as per Andreas F?rber remark, I should avec a
>> >> single DT node for both the resets and clocks.
>> >>
>> >> In the next version I am preparing, the defines doesn't look as
>> >> trivial as in this version, GPIOA_RESET being 128 for instance.
>> >>
>> >> Is it fine for you if I keep the defines part of the binding?
>> >>
>> >>
>> >
>> > It's always better to avoid these files entirely, as they are
>> > a frequent source of merge dependencies, and they make it less
>> > obvious what's going on than having binary values in the dtb
>> > that make sense.
>>
>> I agree it is always painful to have to have to manage these merge dependencies.
>> What I will do, if Philipp agrees, is to list all the values in the
>> binding documentation.
>>
>> Doing that, the user of a reset won't have to do the calculation, and
>> no more merge dependencies.
>
> I'd prefer to have #defines for the reset bits if they are named in the
> documentation and use the names in the dts. But if you want to reference
> reset bits by number in the device tree instead, I won't insist.
>
> Consider using two cells in the phandle for register and bit offset
> instead of a single number that arbitrarily starts at 128.

Thanks for your feedback.

I would prefer using a single cell, which is less error prone in my opinion.
Will you accept this?

Kind regards,
Maxime

>
> regards
> Philipp
>
