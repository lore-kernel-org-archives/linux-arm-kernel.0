From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 18 Jul 2018 16:20:28 +0530
Subject: [PATCH] ARM: dts: exynos5: add missing interrupts for pwm node
In-Reply-To: <CAJKOXPez6cuLyrxBkAKtyx2xiqG7VLWFCBYXkBX_537A=bDpsg@mail.gmail.com>
References: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com>
 <CANAwSgS8z-TQ=nK7dy5YeA8QJV+7cCctZKJT7qn8macQQkyKqg@mail.gmail.com>
 <CAJKOXPez6cuLyrxBkAKtyx2xiqG7VLWFCBYXkBX_537A=bDpsg@mail.gmail.com>
Message-ID: <CANAwSgSaU1kTW3j0OZGwmOWo=p2uHFP8toLUe9FHYEkCJsuLFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 18 July 2018 at 16:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 18 July 2018 at 12:30, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi
>>
>> On 18 July 2018 at 15:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> On 18 July 2018 at 11:34, Anand Moon <linux.amoon@gmail.com> wrote:
>>>> Add missing GIC interrupts property for pwm nodes.
>>>>
>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>> ---
>>>>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>>>> index 5d2f0a0..9406108 100644
>>>> --- a/arch/arm/boot/dts/exynos5.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>>>> @@ -169,6 +169,11 @@
>>>>                 pwm: pwm at 12dd0000 {
>>>>                         compatible = "samsung,exynos4210-pwm";
>>>>                         reg = <0x12DD0000 0x100>;
>>>> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>>>
>>> Indentation here looks weird - spaces used after tabs but not aligned
>>> with first entry. Please indent it properly and align it.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> I ram checkpatch before I submit this patch it shown no error.
>>
>> # scripts/checkpatch.pl --no-signoff -q
>> 0001-ARM-dts-exynos5-add-missing-interrupts-for-pwm-node.patch
>
> That's good, thank you. Still when I look at it in patchwork the
> indentation is wrong:
> https://patchwork.kernel.org/patch/10531753/
> However it can be patchwork's fault, so are you sure that this is
> properly indented and aligned?
>
> BR,
> Krzysztof

I prefer vim and I use following plugin

https://github.com/vivien/vim-linux-coding-style

root at odroidxu4:/usr/src/odroidxu4-4kr-devel# wget -nv
https://patchwork.kernel.org/patch/10531753/mbox/ -O pwm.patch
2018-07-18 10:48:09
URL:https://patchwork.kernel.org/patch/10531753/mbox/ [1460] ->
"pwm.patch" [1]
root at odroidxu4:/usr/src/odroidxu4-4kr-devel#
root at odroidxu4:/usr/src/odroidxu4-4kr-devel# scripts/checkpatch.pl
--no-signoff -q pwm.patch
root at odroidxu4:/usr/src/odroidxu4-4kr-devel#

Is their any other way to test checkpatch please let me know.

Best Regards
-Anand
