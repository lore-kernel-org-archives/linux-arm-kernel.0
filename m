From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 15 May 2014 00:53:04 +0530
Subject: [PATCH v4 4/5] ARM: dts: remove chip specific hdmi hpd pin from
 board
In-Reply-To: <5373B9D4.2060601@samsung.com>
References: <1400035562-16832-1-git-send-email-rahul.sharma@samsung.com>
 <1400035562-16832-5-git-send-email-rahul.sharma@samsung.com>
 <5373B9D4.2060601@samsung.com>
Message-ID: <CAPdUM4P_huO9BNAyUhr+S1di9h+Gxw9T0zJaEUisa+ss4h63gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2014 00:15, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 05/14/14 11:46, Rahul Sharma wrote:
>>
>> From: Rahul Sharma<Rahul.Sharma@samsung.com>
>>
>> "gpx3-7" is chip specific pin in Exynos5420 for hdmi
>> hotplug. This pin is moved to exynos5420-pinctrl.dts
>> and removed from the board file.
>
>
> Rahul, you may need to put the change (moving the pin from smdk5420 board to
> exynos5420-pinctrl.dts) before the patch 3/5.
>

Hi Kukjin,

Ok. I will post with that change tomorrow.

Regards,
Rahul Sharma.

> - Kukjin
>
>
>>
>> Signed-off-by: Rahul Sharma<Rahul.Sharma@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420-smdk5420.dts |    9 ---------
>>   1 file changed, 9 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> index 6910485..11cd9bf 100644
>> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> @@ -131,15 +131,6 @@
>>                 };
>>         };
>>
>> -       pinctrl at 13400000 {
>> -               hdmi_hpd_irq: hdmi-hpd-irq {
>> -                       samsung,pins = "gpx3-7";
>> -                       samsung,pin-function =<0>;
>> -                       samsung,pin-pud =<1>;
>> -                       samsung,pin-drv =<0>;
>> -               };
>> -       };
>> -
>>         hdmi at 14530000 {
>>                 status = "okay";
>>                 hpd-gpio =<&gpx3 7 0>;
