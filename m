From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 10 Jan 2017 09:55:26 +0100
Subject: [PATCH v7 5/8] IIO: add bindings for STM32 timer trigger driver
In-Reply-To: <20170109180448.f3pcpuarhcddo76b@rob-hp-laptop>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-6-git-send-email-benjamin.gaignard@st.com>
 <20170109180448.f3pcpuarhcddo76b@rob-hp-laptop>
Message-ID: <CA+M3ks713cwuaeBwrPett+KrbQC5-w0oyq7aSTrdHReWYVQRoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-09 19:04 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Thu, Jan 05, 2017 at 10:25:41AM +0100, Benjamin Gaignard wrote:
>> Define bindings for STM32 timer trigger
>>
>> version 4:
>> - remove triggers enumeration from DT
>> - add reg parameter
>>
>> version 3:
>> - change file name
>> - add cross reference with mfd bindings
>>
>> version 2:
>> - only keep one compatible
>> - add DT parameters to set lists of the triggers:
>>   one list describe the triggers created by the device
>>   another one give the triggers accepted by the device
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 23 ++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>> new file mode 100644
>> index 0000000..36a6c4a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>> @@ -0,0 +1,23 @@
>> +STMicroelectronics STM32 Timers IIO timer bindings
>> +
>> +Must be a sub-node of an STM32 Timers device tree node.
>> +See ../mfd/stm32-timers.txt for details about the parent node.
>> +
>> +Required parameters:
>> +- compatible:        Must be "st,stm32-timer-trigger".
>> +- reg:               Define triggers configuration of the hardware IP.
>
> Valid values? Not sure this makes sense for use of reg. reg should be
> how you address or id a device.

I use reg like an id to distinguish device and get the right
configuration inside
the driver.

>
>> +
>> +Example:
>> +     timers at 40010000 {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             compatible = "st,stm32-timers";
>> +             reg = <0x40010000 0x400>;
>> +             clocks = <&rcc 0 160>;
>> +             clock-names = "clk_int";
>> +
>> +             timer {
>
> This would also need an unit address.

Ok I will fix that

>
>> +                     compatible = "st,stm32-timer-trigger";
>> +                     reg = <0>;
>> +             };
>> +     };
>> --
>> 1.9.1
>>



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
