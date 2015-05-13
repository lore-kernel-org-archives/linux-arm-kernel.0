From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 13 May 2015 14:15:15 +0530
Subject: [PATCHv5 2/5] ARM: dts: Odroid-XU3 Enable TMU at Exynos5422 base
In-Reply-To: <CAJKOXPfC9nGEsYJ3qJ6m_iMsB=D8_6sOEpLQzEvmLry5zS5j3g@mail.gmail.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
 <1431499020-3912-3-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPca-2qdYOoMQOnu0jigOYwUvMTWZwdM2kRTkBXw-ws4yw@mail.gmail.com>
 <CANAwSgQ=30j4A_nCd26kzxi=rdsh32+Srwuc5EaJigLhJ2r4jA@mail.gmail.com>
 <CAJKOXPfC9nGEsYJ3qJ6m_iMsB=D8_6sOEpLQzEvmLry5zS5j3g@mail.gmail.com>
Message-ID: <CANAwSgQj4Hswi2B-7+oFCxSWoau5ffHJp6h1pZ+qikdvTrLDgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2015 at 14:02, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> 2015-05-13 17:21 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>> On 13 May 2015 at 12:51, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
>>> 2015-05-13 15:36 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>>> This changes enables TMU IP block on the Exynos5422 Odroid-XU3
>>>> device.
>>>>
>>>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>>>> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>> ---
>>>>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 25 +++++++++++++++++++++++++
>>>>  1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>> index 9446e28..cd78816 100644
>>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>> @@ -319,6 +319,31 @@
>>>>                 #cooling-cells = <2>;
>>>>                 cooling-levels = <0 130 170 230>;
>>>>         };
>>>> +
>>>> +       tmu at 10060000 {
>>>
>>> Here and for other overrides please use label notation, like:
>>>
>>> &tmu_cpu0 {
>>>               ...
>>> };
>>>
>>>> +               vtmu-supply = <&ldo10_reg>;
>>>
>>> I am curious, how did you find that LDO10 supplies TMU unit?
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Hi Krzysztof,
>>
>> I have re-base my work on earlier Lukasz Majewski patches.
>>
>> https://patchwork.kernel.org/patch/5693201/
>
> NAK.
> I am sorry, but this is not sufficient explanation. Actually such
> explanation could mean that you did just blindly copied everything
> instead of developing it.
>
> You cannot use some regulator here just because some Exynos4 boards
> use it. You have to be sure that this regulator supplies this part of
> SoC or device.

Hi Krzysztof,

Ok as if now I don't clearly know how I works. But I will study the
regulators and update it.

Lukasz Majewski could you help me out on how it suppose to be,

-Anand Moon
