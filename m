From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 19:40:55 +0900
Subject: [PATCH 7/7] ARM: S5PC210: I2C{3, 4, 5, 6, 7} device support
In-Reply-To: <006b01cb6088$ffc17b80$ff447280$%han@samsung.com>
References: <20100930044859.GA16923@july>
	<000b01cb6067$99850240$cc8f06c0$%seo@samsung.com>
	<AANLkTinC9U3mehOVGWSM26TjMVyx9o6fBgLrXUKQmOcb@mail.gmail.com>
	<AANLkTik9Q7e=nzOmKsxEBeeJn-5JcQpKJfTSfGqLB21G@mail.gmail.com>
	<AANLkTin9tR4+CBa+r6mHsJdFYxzkaK1CA+_WKhTZkacs@mail.gmail.com>
	<006601cb6081$bf8a7140$3e9f53c0$%han@samsung.com>
	<AANLkTikmTyOnmA7eaN0_Vysf+0BviDX428MhZHTffpe7@mail.gmail.com>
	<006b01cb6088$ffc17b80$ff447280$%han@samsung.com>
Message-ID: <AANLkTikgXpJPnbQGchvHSCTshKzAO5GJyGHio=6Q0RZJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 7:19 PM, Jongsun Han <jongsun.han@samsung.com> wrote:
> On Thu, Sep 30, 2010 at 6:27 PM, Jongsun Han <jongsun.han@samsung.com>
>> wrote:
>> > On Thu, Sep 30, 2010 at 3:50 PM, Jassi Brar <jassisinghbrar@gmail.com>
>> wrote:
>> >> > On Thu, Sep 30, 2010 at 3:27 PM, Kyungmin Park <kmpark@infradead.org>
>> wrote:
>> >> >> On Thu, Sep 30, 2010 at 3:20 PM, Jeongbae Seo
>> <jeongbae.seo@samsung.com>
>> >> wrote:
>> >> >>> Kyungmin wrote:
>> >> >>>> From: Kyungmin Park <kyungmin.park@samsung.com>
>> >> >>>>
>> >> >>>> S5PC210 support more I2C devices than previous SoCs.
>> >> >>>> And to prevent the wrong usage use the s5p prefix instead of s3c.
>> >> >>>>
>> >> >>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> >> >>>> ---
>> >> >>>> ?arch/arm/mach-s5pv310/Kconfig ? ? ? ? ? ?| ? 15 +++++++
>> >> >>>> ?arch/arm/mach-s5pv310/Makefile ? ? ? ? ? | ? ?5 ++
>> >> >>>> ?arch/arm/mach-s5pv310/setup-i2c3.c ? ? ? | ? 25 +++++++++++
>> >> >>>> ?arch/arm/mach-s5pv310/setup-i2c4.c ? ? ? | ? 25 +++++++++++
>> >> >>>> ?arch/arm/mach-s5pv310/setup-i2c5.c ? ? ? | ? 25 +++++++++++
>> >> >>>> ?arch/arm/mach-s5pv310/setup-i2c6.c ? ? ? | ? 25 +++++++++++
>> >> >>>> ?arch/arm/mach-s5pv310/setup-i2c7.c ? ? ? | ? 25 +++++++++++
>> >> >>>> ?arch/arm/plat-s5p/Kconfig ? ? ? ? ? ? ? ?| ? 25 +++++++++++
>> >> >>>> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? | ? ?5 ++
>> >> >>>> ?arch/arm/plat-s5p/dev-i2c3.c ? ? ? ? ? ? | ? 67
>> >> >>>> ++++++++++++++++++++++++++++++
>> >> >>>> ?arch/arm/plat-s5p/dev-i2c4.c ? ? ? ? ? ? | ? 67
>> >> >>>> ++++++++++++++++++++++++++++++
>> >> >>>> ?arch/arm/plat-s5p/dev-i2c5.c ? ? ? ? ? ? | ? 67
>> >> >>>> ++++++++++++++++++++++++++++++
>> >> >>>> ?arch/arm/plat-s5p/dev-i2c6.c ? ? ? ? ? ? | ? 67
>> >> >>>> ++++++++++++++++++++++++++++++
>> >> >>>> ?arch/arm/plat-s5p/dev-i2c7.c ? ? ? ? ? ? | ? 67
>> >> >>>> ++++++++++++++++++++++++++++++
>> >> >>>> ?arch/arm/plat-samsung/include/plat/iic.h | ? ?5 ++
>> >> >>>> ?15 files changed, 515 insertions(+), 0 deletions(-)
>> >> >>>> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c3.c
>> >> >>>> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c4.c
>> >> >>>> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c5.c
>> >> >>>> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c6.c
>> >> >>>> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c7.c
>> >> >>>> ?create mode 100644 arch/arm/plat-s5p/dev-i2c3.c
>> >> >>>> ?create mode 100644 arch/arm/plat-s5p/dev-i2c4.c
>> >> >>>> ?create mode 100644 arch/arm/plat-s5p/dev-i2c5.c
>> >> >>>> ?create mode 100644 arch/arm/plat-s5p/dev-i2c6.c
>> >> >>>> ?create mode 100644 arch/arm/plat-s5p/dev-i2c7.c
>> >> >>>>
>> >> >>>
>> >> >>> Hi Kyungmin,
>> >> >>>
>> >> >>> We are considering another way not to make additional new i2c dev
>> files.
>> >> >>> In my opinion, this patch looks not bad but we'd better make an
>> effort to
>> >> >>> avoid having the more similar file.
>> >> >>
>> >> >> Actually I also it's not good approach, but as there's no comment or
>> >> >> discuss about this I send the patches.
>> >> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-
>> >> August/022615.html
>> >> >>
>> >> >> If you have good method or approaches, I'm welcome.
>> >> >
>> >> > First, these are device definitions and gpio set callbacks and
>> >> > shouldn't take much
>> >> > of space. So, perhaps these all could be built upon single I2C
>> support
>> >> > selection.
>> >>
>> >> That's my first propose.
>> >
>> > Hi, Kyungmin and Jassi
>> >
>> > I think that parts of i2c in S5PV310 aren't used depending on the usage
>> of
>> > S5PV310.
>> > It's better define the number of i2c devs being used instead of using
>> single I2C
>> > support selection.
>>
>> Can you tell me in detail? I don't know what do you mean?
>> and FYI, universal board uses all I2Cs except I2C2.
>>
>
> For example,
> If i2c(0..4) except 2 are used in S5PV310, set the number of i2c dev as 5.
> Then only i2c(0..4) are built without building i2c(5..7).
then what's the condition of I2C2?

If it don't use i2c2 and i2c3, then how to configure it?
>
>> >
>> >> >
>> >> > Second, if we must build them conditionally, how about having all in
>> >> > one file with
>> >> > each device's definition and callback surrounded by corresponding
>> ifdef ?
>> >> > That would alteast save us file-count.
>> >>
>> >> This method is also no problem if all of person are agreed.
>> >>
>> >> So just choose it and make a conclusion.
>> >>
>> >> Thank you,
>> >> Kyungmin Park
>> >> >
>> >
>> > I agree with Jassi's opinion keeping setup-i2c(0..2) and dev-i2c(0..2)
>> for
>> > backward compatibility and
>>
>> Of course it should be. and there's no code to brake the existing codes.
>>
>> > adding a file which handles i2c(0..7) for S5PV310 and coming
>> > Samsung
>> > soc.
>>
>> Do you mean create the new i2c[0-7] for s5pv310?
>> I think it's better to give some example how to implement as your word.
>>
>
> set-i2c.c in S5PV310 machine directory sets all i2c related gpio.
> dev-i2c.c which is created in plat directory sets all i2c devs plat data.
You mean use the #ifdef ~ #endif for each I2Cs.

To Kgene,
Any comments? I think you already mentioned that don't use #ifdef ~
#endif at c files if possible.
In this case are you okay?

Thank you,
Kyungmin Park

>
>> >
>> > Best Regards
>> > Jongsun Han
>> >
>> >
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
