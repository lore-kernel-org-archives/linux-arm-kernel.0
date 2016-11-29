From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 29 Nov 2016 12:57:50 +0100
Subject: [PATCH v2 2/2] ARM: dts: da850-lcdk: specify the maximum pixel
 clock rate for tilcdc
In-Reply-To: <4f2a02c4-062f-6faf-1024-2a8718a9701f@ti.com>
References: <1480335328-4010-1-git-send-email-bgolaszewski@baylibre.com>
 <1480335328-4010-3-git-send-email-bgolaszewski@baylibre.com>
 <4f2a02c4-062f-6faf-1024-2a8718a9701f@ti.com>
Message-ID: <CAMpxmJVN08Xw8AYeAxhgGj+XQnk60Wm1O+re_tfftYwwjKcQPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-29 11:53 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Monday 28 November 2016 05:45 PM, Bartosz Golaszewski wrote:
>> Due to memory throughput constraints any display mode for which the
>> pixel clock rate exceeds the recommended value of 37500 KHz must be
>> filtered out.
>
> I think there might be more reasons than memory throughput constraints
> for the reasoning behind 37.5Mhz cap on pixel clock. Why not just refer
> to the datasheet section that places this constraint so we know its a
> hardware restriction.
>
>>
>> Specify the max-pixelclock property for the display node for
>> da850-lcdk.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/boot/dts/da850-lcdk.dts | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
>> index d864f11..1283263 100644
>> --- a/arch/arm/boot/dts/da850-lcdk.dts
>> +++ b/arch/arm/boot/dts/da850-lcdk.dts
>> @@ -285,6 +285,7 @@
>>
>>  &display {
>>       status = "okay";
>> +     max-pixelclock = <37500>;
>
> Should this not be in da850.dtsi since its an SoC imposed constraint? If
> a board needs narrower constraint, it can override it. But I guess most
> well designed boards will just hit the SoC constraint.
>

Both issues fixed in v3.

Thanks,
Bartosz Golaszewski
