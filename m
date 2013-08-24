From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sat, 24 Aug 2013 11:59:31 +0800
Subject: [PATCH v7 05/11] ARM: dts: enable hi4511 with device tree
In-Reply-To: <8761uxsiox.fsf@linaro.org>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-6-git-send-email-haojian.zhuang@linaro.org>
 <8761uxsiox.fsf@linaro.org>
Message-ID: <CAD6h2NSioCru+VGGZEOiji96Jm3YKLJFfmMx0H4i4QFjx8VmUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 August 2013 02:07, Kevin Hilman <khilman@linaro.org> wrote:
> [+ DT maintainers]
>
> Haojian Zhuang <haojian.zhuang@linaro.org> writes:
>
>> Enable Hisilicon Hi4511 development platform with device tree support.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> There seems to be use of several new vendor-specific bindings here that
> are not documented anywhere:
>
> hisilicon,sctrl
> hisilicon,pmctrl
> hisilicon,clk-mux
> hisilicon,clk-div
> hisilicon,clk-gate
>
Those are in clock bindings with clock patches. Since you're always
requesting those patch going through Mike's tree. I didn't pick them up
into this patch set.

> Not only that, the clock-related compatible properties used here are
> different than the ones specificed PATCH 10/11 of this series where you
> document some clock bindings.

No. #10 is only for Hi3716. It's a little different on hi3xxx. But now I dropped
this patch in my pull request.

Since there's still some comments on the whole v7 patchset, I'll update with
a v8.
>
> also...
>
> [...]
>
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +     aliases {
>> +             serial0 = &uart0;
>> +             serial1 = &uart1;
>> +             serial2 = &uart2;
>> +             serial3 = &uart3;
>> +             serial4 = &uart4;
>> +     };
>> +
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu0: cpu at 0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a9";
>> +                     reg = <0x0>;
>> +                     next-level-cache = <&L2>;
>> +             };
>> +     };
>> +
>> +     osc32k: osc32k {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <32768>;
>> +             clock-output-names = "osc32khz";
>> +     };
>
> ...seems many of the recent users of clocks have grouped them into a
> clocks {} grouping on a "simple-bus".
>
> DT folks: is there a rule of thumb on how whether these fixed clocks
> should be grouped on a simple bus?
>
> Kevin
