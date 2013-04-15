From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 15 Apr 2013 17:02:02 +0530
Subject: [PATCH 3/7] ARM: exynos: add missing properties for combiner IRQs
In-Reply-To: <201304151041.44805.arnd@arndb.de>
References: <1365775405-115297-1-git-send-email-arnd@arndb.de>
 <1365775405-115297-4-git-send-email-arnd@arndb.de>
 <CAK9yfHzubnyo7wD4gmmjLobkoy2qPXWyPp-0GQq8wiJH1PWZTg@mail.gmail.com>
 <201304151041.44805.arnd@arndb.de>
Message-ID: <CAK9yfHwXYRqo2yG1moWvMnEmNWXCVL7a9eKzi2we=QmdpVsz-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> > diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
>> > index 36d4299..f83c3c1 100644
>> > --- a/arch/arm/boot/dts/exynos4212.dtsi
>> > +++ b/arch/arm/boot/dts/exynos4212.dtsi
>> > @@ -26,6 +26,15 @@
>> >                 cpu-offset = <0x8000>;
>> >         };
>> >
>> > +       interrupt-controller at 10440000 {
>>
>> Don't we need a node name here (combiner:interrupt-controller at 10440000)?
>
> Why?

Since it is being referenced as "&combiner" by other bindings, i
thought that was required.

The "combiner:" part is just a label. Actually I think the preferred
> syntax is
>
> &combiner {
>         samsung,combiner-nr = <18>;
> };
>
> which is much shorter to write, but I did not want to change the style used
> in the rest of the file.
>
>> > +                combiner-nr = <18>;
>>     ^^^^^^^^^^^
>> nit: tabs instead of space would look better.
>
> I fixed that up locally, but I think I sent out the wrong version.

OK.

>
>> > diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
>> > index d75c047..4cb657e 100644
>> > --- a/arch/arm/boot/dts/exynos4412.dtsi
>> > +++ b/arch/arm/boot/dts/exynos4412.dtsi
>> > @@ -26,6 +26,15 @@
>> >                 cpu-offset = <0x4000>;
>> >         };
>> >
>> > +       interrupt-controller at 10440000 {
>> > +               combiner-nr = <20>;
>> Same as above (for exynos4212.dtsi).
>>
>> > +               interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
>> > +                            <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
>> > +                            <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
>> > +                            <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
>> > +                            <0 107 0>, <0 108 0>>, <0 48 0>, <0 42 0>;
>>                                                               ^^^
>> Syntax error.
>>
>> We have a combiner node defined in exynos4x12.dtsi. With the bindings
>> now defined separately in 4212 and 4412 dtsi files, probably the one
>> in 4x12 could be dropped?
>
> I did not see that one, but it seems to have the wrong numbers in the last
> four interrupt specifiers. I think it would be better to just fix that one
> and keep using it.

OK. Do you want me to fix it and send as a patch or would you like to do it?


-- 
With warm regards,
Sachin
