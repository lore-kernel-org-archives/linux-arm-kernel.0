From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 15 May 2014 11:17:06 +0530
Subject: [PATCH v4 4/5] ARM: dts: remove chip specific hdmi hpd pin from
 board
In-Reply-To: <5373C95B.5080601@gmail.com>
References: <1400035562-16832-1-git-send-email-rahul.sharma@samsung.com>
 <1400035562-16832-5-git-send-email-rahul.sharma@samsung.com>
 <5373C95B.5080601@gmail.com>
Message-ID: <CAPdUM4N5mf1Mby06qDBcm5eArX7c1rbBmUhSCR_nKojoEmB12g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2014 01:21, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Rahul,
>
> On 14.05.2014 04:46, Rahul Sharma wrote:
>> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>>
>> "gpx3-7" is chip specific pin in Exynos5420 for hdmi
>> hotplug. This pin is moved to exynos5420-pinctrl.dts
>> and removed from the board file.
>>
>> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420-smdk5420.dts |    9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> index 6910485..11cd9bf 100644
>> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> @@ -131,15 +131,6 @@
>>               };
>>       };
>>
>> -     pinctrl at 13400000 {
>> -             hdmi_hpd_irq: hdmi-hpd-irq {
>> -                     samsung,pins = "gpx3-7";
>> -                     samsung,pin-function = <0>;
>> -                     samsung,pin-pud = <1>;
>> -                     samsung,pin-drv = <0>;
>
> Again, the same comment as for patch 1/5. This pin is being configured
> as input, which doesn't look like a dedicated special function pin.
> Shouldn't this node rather stay here?
>
Yea, I will take care fo this in v5.

> Best regards,
> Tomasz
