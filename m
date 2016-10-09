From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 10 Oct 2016 02:49:01 +0900
Subject: [PATCH v3 00/17] pinctrl: exynos/samsung: Add header with values
 used for configuration
In-Reply-To: <20161009163910.GB9672@kozik-lap>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
 <CA+Ln22Eotn=dLyA8KYT_6Fnwvp1sTSxzP8DepAFB2P8EUMME6Q@mail.gmail.com>
 <20161009163910.GB9672@kozik-lap>
Message-ID: <CA+Ln22GgjF=wVzL3fF7xzvOZtJpiZjVcFTrvDQAu6T2RCfY89g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-10 1:39 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Sun, Oct 09, 2016 at 04:04:11PM +0900, Tomasz Figa wrote:
>> Hi Krzysztof,
>>
>> 2016-09-04 20:04 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
>> >
>> > Hi,
>> >
>> > Changes since v2
>> > ================
>> > 1. Combine separate patchsets into one. Previously I sent separately the fixes
>> >    and changes for S3C platforms.
>> > 2. Fix issues pointed during review.
>> > 3. Add review tags.
>> >
>> > Changes since v1
>> > ================
>> > 1. Follow Arnd's suggestion about moving the macros to common place.
>> > 2. Subjects: replace "GPIO" with "pinctrl".
>> > 3. There were some major changes here so I did not add Javier's
>> >    reviewed-by and tested-by tags.
>> >
>> > Merging
>> > =======
>> > Patches #1 and #2 should probably go through pinctrl tree. In that case I would
>> > appreciate a stable branch/tag so DTS could base on top of it.
>> >
>> > Goal
>> > ====
>> > Increase readability:
>> >         uart0_data: uart0-data {
>> >                 samsung,pins = "gpa0-0", "gpa0-1";
>> > -               samsung,pin-function = <2>;
>> > -               samsung,pin-pud = <0>;
>> > -               samsung,pin-drv = <0>;
>> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>> > +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>>
>> I like the idea, thanks for cleaning this up. However I'd like to
>> bikeshed the prefix a bit. Since the properties are already prefixed
>> by "samsung,", I think it would make much more sense to also prefix
>> the generic values with "SAMSUNG_". Of course for soc/family-specific
>> values, the soc/family name prefix sounds right.
>
> I am lost. Sorry, I don't get what kind of final prefixes you would like
> to have.
>
> SAMSUNG_EXYNOS4_PIN_DRV_LV1
> SAMSUNG_EXYNOS5260_PIN_DRV_LV1
> ?

For SoC-specific definitions:

EXYNOS4_PIN_DRV_LV1
EXYNOS5260_PIN_DRV_LV1

>
>> Similarly for rest of the value names, such as SAMSUNG_PIN_PUD instead
>> of SAMSUNG_PIN_PULL, which obviously sounds more like correct English,
>> however hurts the consistency and could confuse the people writing new
>> dts files.
>
> SAMSUNG_S3C64XX_PIN_PUD_NONE
> SAMSUNG_EXYNOS_PIN_PUD_NONE

For definitions common for the whole Samsung pinctrl driver:

SAMSUNG_PIN_PUD_NONE

...

But actually I think I missed the fact that there is almost no common
definitions. Is that correct? Was that the missing part of my
understanding?

Best regards,
Tomasz
