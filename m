From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 24 Mar 2016 19:25:35 +0900
Subject: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
In-Reply-To: <20160324095332.GS2566@sirena.org.uk>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
 <20160324095332.GS2566@sirena.org.uk>
Message-ID: <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 6:53 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 24, 2016 at 05:12:05PM +0900, Krzysztof Kozlowski wrote:
>
>>                       buck9_reg: BUCK9 {
>>                               regulator-name = "vdd_2.8v_ldo";
>>                               regulator-min-microvolt = <3000000>;
>> -                             regulator-max-microvolt = <3750000>;
>> +                             regulator-max-microvolt = <3755000>;
>>                               regulator-always-on;
>>                               regulator-boot-on;
>>                       };
>
> Why does this regulator even have voltage constraints configured?  Is
> there any intention that it should ever be varied at runtime?

Good question. I was also wondering that, if tetting it by 5 mV lower
causes failure, then the constraints are actually fixed at 3.755 V. I
do not know the answer. Boards schematics do not specify the
requirement here, datasheet for PMIC says default value of 3.4V. Heh,
maybe the regulator driver is missing proper starting value for 'vsel'
(datasheet says values in register start from 0x40 -> 3 V). Something
looks wrong here...

I'll look at it after weekend. For now I applied my patch to the
for-next, so the next should be fixed.

Best regards,
Krzysztof
