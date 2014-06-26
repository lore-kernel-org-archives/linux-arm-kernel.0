From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Thu, 26 Jun 2014 17:16:14 +0530
Subject: [PATCH 4/4 v2] ARM: DTS: Add NTC thermistor nodes to Exynos5420
 based Peach_PIT
In-Reply-To: <CAHfPSqBL9hH+r8Fy4GbbY1E_sJVCP-gpDHATDJgRHP4wKrFaiA@mail.gmail.com>
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
 <1403677773-21141-5-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=WeuFhGK=JNEm20CT73J=c1Zc_dZGQT6bKeob895M+kQA@mail.gmail.com>
 <CAHfPSqBL9hH+r8Fy4GbbY1E_sJVCP-gpDHATDJgRHP4wKrFaiA@mail.gmail.com>
Message-ID: <CAHfPSqBx7o2Lcoz89VgnUbCKVAxi6mG_j3piTe=fWrF853gWhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On 26 June 2014 11:46, Naveen Krishna Ch <naveenkrishna.ch@gmail.com> wrote:
> Doug,
>
> On 26 June 2014 02:10, Doug Anderson <dianders@chromium.org> wrote:
>> Naveen,
>>
>> On Tue, Jun 24, 2014 at 11:29 PM, Naveen Krishna Chatradhi
>> <ch.naveen@samsung.com> wrote:
>>> Exynos5420 based Peach PIT board has 4 NTC thermistors to measure
>>> temperatures at various points on the board.
>>>
>>> IIO based ADC becomes the parent and NTC thermistors are the childs,
>>> via the HWMON interface.
>>>
>>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>>> Cc: Doug Anderson <dianders@chromium.org>
>>> ---
>>> Changes since v1:
>>> 1. Arranged the ADC node alphabetical
>>> 2. Added "status = "okay"" to the ADC node
>>>
>>> This patch needs
>>> 1. MAX77802 PMIC device tree nodes (for ldo9)
>>>    https://www.mail-archive.com/devicetree at vger.kernel.org/msg31430.html
>>> 2. Uses the DT documentation for NTC thermistors updated with vendor-prefix
>>>
>>> This patch set is tested
>>> 1. On Peach PIT board via sysfs entry exposed by hwmon
>>> localhost ~ # cat /sys/class/hwmon/hwmon*/device/temp1_input
>>> 37436
>>> 36449
>>> 38560
>>> 38059
>>>
>>> 2. Backward compatibility is tested by replacing "murata" with "ntc"
>>>    in the dts nodes and running the above test.
>>>
>>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   34 ++++++++++++++++++++++++++++
>>>  1 file changed, 34 insertions(+)
>>
>> Now that Javier has spun his patch, perhaps you can fold the "pi"
>> version in here too?
>
> Sure, thanks for the information.
>
> Snow also needs the adc nodes.
> Will try to implement an adc fragment for PIT, PI and Snow.

I've a plan to create a common file (cros-exynos-peach.dts) for
exynos5420-peach-pit.dts and exynos5800-peach-pi.dts
And add the ADC nodes directly into that.

In favor of the above, can you abandon the following patches

1. [PATCH 3/4 v2] ARM: DTS: use new compatible string for thermistors in trats2
    http://www.spinics.net/lists/linux-samsung-soc/msg33037.html

2. [PATCH 4/4 v2] ARM: DTS: Add NTC thermistor nodes to Exynos5420
based Peach_PIT
http://www.spinics.net/lists/linux-samsung-soc/msg33038.html

>
>>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> Tested-by: Doug Anderson <dianders@chromium.org>
>
>
>
> --
> Shine bright,
> (: Nav :)



-- 
Thanks,
(: Nav :)
