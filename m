From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Sat, 16 May 2015 09:33:13 +0900
Subject: [PATCH 0/4] ARM: multi_v7_defconfig: Stuff for Exynos
In-Reply-To: <5555FEC4.6050204@collabora.co.uk>
References: <1431694142-32141-1-git-send-email-k.kozlowski.k@gmail.com>
 <5555FEC4.6050204@collabora.co.uk>
Message-ID: <CAJKOXPfFrJRPXWO3sNuRCKoiQXS4=tFQJpmuQvt8PAebDrTSuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-15 23:12 GMT+09:00 Javier Martinez Canillas
<javier.martinez@collabora.co.uk>:
> Hello Krzysztof,
>
> On 05/15/2015 02:48 PM, Krzysztof Kozlowski wrote:
>> Dear Kukjin,
>>
>> The patchset enables various config options on multi_v7 config
>> for Exynos boards. The first two patches are actually resend.
>>
>> Arnd suggested [0] that this can go through your tree.
>>
>> Patchset is rebased on next-20150515 and Javier's patchset [1]
>> (to avoid conflicts around regulators and clocks).
>>
>> Please let me know if this should be rebased on other commit.
>>
>> [0] http://www.spinics.net/lists/kernel/msg1991518.html
>> [1] http://www.spinics.net/lists/kernel/msg1990767.html
>>
>> Best regards,
>> Krzysztof
>>
>>
>> Krzysztof Kozlowski (4):
>>   ARM: multi_v7_defconfig: Enable CPU idle for Exynos
>>   ARM: multi_v7_defconfig: Enable PMIC and MUIC drivers for Exynos
>>     boards
>>   ARM: multi_v7_defconfig: Enable TMU for Exynos
>>   ARM: multi_v7_defconfig: Enable OHCI on Exynos
>>
>>  arch/arm/configs/multi_v7_defconfig | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>
> On a first look, I agree with all the Kconfig symbols but I noticed that
> you are adding them to be built-in while the current policy for multi_v7
> is to build as much as possible as a module.
>
> Could you please add as =m for all the tristate symbols that can be build
> as a module?

Your request makes sense. For many Exynos boards we got used to
compiling it into the kernel, not as a module, but I think only reason
behind this is convenience. I'll try to switch to modules.

Best regards,
Krzysztof
