From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 15 Nov 2012 14:28:40 +0530
Subject: [PATCH v3 05/11] ARM: dts: add exynos4 clock controller nodes
In-Reply-To: <4979279.mb3rWrdaG3@flatron>
References: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
 <1352930853-12268-6-git-send-email-thomas.abraham@linaro.org>
 <4979279.mb3rWrdaG3@flatron>
Message-ID: <CAJuYYwRHg=NLDe1TaOtE-vigjctYRrtkU6o1-w_52tszUth80Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2012 04:57, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Thursday 15 of November 2012 03:37:27 Thomas Abraham wrote:
>> Add clock controller nodes for Exynos4210 and Exynos4x12 SoC's.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>  arch/arm/boot/dts/exynos4210.dtsi |    6 ++++++
>>  arch/arm/boot/dts/exynos4x12.dtsi |    6 ++++++
>>  2 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos4210.dtsi
>> b/arch/arm/boot/dts/exynos4210.dtsi index d6fc306..f7daa09 100644
>> --- a/arch/arm/boot/dts/exynos4210.dtsi
>> +++ b/arch/arm/boot/dts/exynos4210.dtsi
>> @@ -50,6 +50,12 @@
>>               samsung,mct-nr-local-irqs = <4>;
>>       };
>>
>> +     clock: clock-controller at 0x10030000 {
>> +             compatible = "samsung,exynos4210-clock";
>> +             reg = <0x10030000 0x20000>;
>> +             #clock-cells = <1>;
>> +     };
>> +
>>       pinctrl_0: pinctrl at 11400000 {
>>               compatible = "samsung,pinctrl-exynos4210";
>>               reg = <0x11400000 0x1000>;
>> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi
>> b/arch/arm/boot/dts/exynos4x12.dtsi index 7cbbd19..bcfdaac 100644
>> --- a/arch/arm/boot/dts/exynos4x12.dtsi
>> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
>> @@ -35,6 +35,12 @@
>>                            <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>;
>>       };
>>
>> +     clock: clock-controller at 0x10030000 {
>> +             compatible = "samsung,exynos4412-clock";
>
> nitpick: I forgot to mention about it in my comments for patch 3, but
> wouldn't it be better to call it "samsung,exynos4x12-clock"?

I prefer to use a specific version for compatible strings. I remember
that there have been discussion in the past on this, but I belong to
the camp which favors using fixed compatible values over wildcards in
compatible values. It is easier to track and less problematic in case
a new Exynos4x12 SoC comes up with altogether a different clock
architecture. We have used this method for wdt, rtc, i2c and many
other drivers and it has proven to be suit well. For instance, for
i2c, we have two variants - s3c2410 and s3c2440 and we can use this
most of all the Samsung SoCs.

>
>> +             reg = <0x10030000 0x20000>;
>> +             #clock-cells = <1>;
>> +     };
>> +
>>       pinctrl_0: pinctrl at 11400000 {
>>               compatible = "samsung,pinctrl-exynos4x12";
>>               reg = <0x11400000 0x1000>;
>
> Otherwise looks fine.

Thanks,
Thomas.
