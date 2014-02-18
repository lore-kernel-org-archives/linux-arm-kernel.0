From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Feb 2014 08:16:13 -0800
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <5302B306.8090503@samsung.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <52F99056.6010906@samsung.com>
 <CAOesGMgdDnSc=Y8i6JYeGewCh1RPYZ_AxocxKzSD265fa2-yrA@mail.gmail.com>
 <201402141806.12711.arnd@arndb.de> <5302B306.8090503@samsung.com>
Message-ID: <CAOesGMhnUDcUL7hREV=EYEGr5YG-ZLL6v9NiGcrBr6477WfdyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 5:10 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 02/15/14 02:06, Arnd Bergmann wrote:
>>
>> On Thursday 13 February 2014, Olof Johansson wrote:
>>>
>>> On Mon, Feb 10, 2014 at 6:52 PM, Kukjin Kim<kgene.kim@samsung.com>
>>> wrote:
>>>>
>>>> On 02/13/14 04:14, Arnd Bergmann wrote:
>>>>>
>>>>> On Wednesday 12 February 2014 13:04:40 Kumar Gala wrote:
>>>>
>>>> Basically, I agreed with Arnd's suggestion to use ARCH_SBSA. Or we need
>>>> to
>>>> define level in Kconfig like ARCH_SBSA_L1 for level1. BTW, how about
>>>> compliant with SBSA Level1 and having some specific features?
>>
>>
> Well, how about ARMv8 mobile SoC? I think, it is not compatible with SBSA.
> For example, you know MCT can be used for ARMv8 cores instead of ARCH Timer.
> So I'm not sure ARCH_SBSA is really good choice...
>
>
>> My feeling is that we don't need to use the levels for Kconfig, although
>> we might want to use them DT compatible strings, even if it ends up
>> looking
>> a little funny when you do
>>
>>         compatible = "arm,sbsa-l3", "arm,sbsa-l2", "arm,sbsa-l1";
>>
>>> What kind of features are you expecting though? More IP
>>> blocks/devices? Those are just kernel config options to enable,
>>> ideally as modules.
>>
>>
>> Right, I think we can just put them into defconfig. No need to
>> "select" them from Kconfig since the extra options wouldn't be
>> required for booting or using the system.
>>
> As I commented above, how about MCT? Samsung has a plan to use MCT on ARMv8,
> it is not for used for GH7 though...

It looks like the clocksource drivers are all based around being
enabled based on platforms instead of individually selectable. That
causes a problem here. I think we should change the clocksource
Kconfig instead. Then it's just a matter of making sure your defconfig
has the needed driver enabled.

(Adding Daniel and Thomas in case they have objections to that approach)


-Olof
