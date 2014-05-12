From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 12 May 2014 16:23:42 +0530
Subject: [PATCH v3 5/5] ARM: dts: enable hdmi for exynos5800 based
 peach-pi board
In-Reply-To: <5370A7D0.5030409@samsung.com>
References: <1399890248-27409-1-git-send-email-rahul.sharma@samsung.com>
 <1399890248-27409-6-git-send-email-rahul.sharma@samsung.com>
 <5370A7D0.5030409@samsung.com>
Message-ID: <CAPdUM4PPQbbtDSZ6_qu-Ld9ku4iNz-zanRVODTvMrLknPStZWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2014 16:22, Arun Kumar K <arun.kk@samsung.com> wrote:
> Hi Rahul,
>
> On 05/12/14 15:54, Rahul Sharma wrote:
>> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>>
>> Enable hdmi for peach-pi board.
>>
>> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts |   26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> index 742655b..bbb445a 100644
>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> @@ -72,6 +72,13 @@
>>               samsung,pin-pud = <0>;
>>               samsung,pin-drv = <0>;
>>       };
>> +
>> +     hdmi_hpd_irq: hdmi-hpd-irq {
>> +             samsung,pins = "gpx3-7";
>> +             samsung,pin-function = <0>;
>> +             samsung,pin-pud = <1>;
>> +             samsung,pin-drv = <0>;
>> +     };
>
> This node is already added in 5420-pinctrl.dtsi in patch 3/5.
> You can drop it from here.
>

yea correct. I will remove this pin.

Regards,
Rahul Sharma.

> Regards
> Arun
>
>>  };
>>
>>  &rtc {
>> @@ -134,6 +141,25 @@
>>       };
>>  };
>>
>> +&i2c_2 {
>> +     status = "okay";
>> +     samsung,i2c-sda-delay = <100>;
>> +     samsung,i2c-max-bus-freq = <66000>;
>> +     samsung,i2c-slave-addr = <0x50>;
>> +
>> +     hdmiddc at 50 {
>> +             reg = <0x50>;
>> +     };
>> +};
>> +
>> +&hdmi {
>> +     status = "okay";
>> +     hpd-gpio = <&gpx3 7 2>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&hdmi_hpd_irq>;
>> +     ddc = <&i2c_2>;
>> +};
>> +
>>  /*
>>   * Use longest HW watchdog in SoC (32 seconds) since the hardware
>>   * watchdog provides no debugging information (compared to soft/hard
>>
