From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue, 12 Apr 2016 17:18:49 +0800
Subject: [PATCH v2 04/16] arm64: dts: Add Hi6220 gpio configuration nodes
In-Reply-To: <CACRpkdb8x1EVMDgrV36+neGk1O+rGnSpj9F0A5stHN_d6B-EAA@mail.gmail.com>
References: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
 <1459589383-16914-5-git-send-email-guodong.xu@linaro.org>
 <CACRpkdb8x1EVMDgrV36+neGk1O+rGnSpj9F0A5stHN_d6B-EAA@mail.gmail.com>
Message-ID: <CAFGCpxwBJBr3=tQQ5Cj1aGQURyx3qa02s6G2SePeg1B-iSa7FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2016 at 03:28, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Apr 2, 2016 at 11:29 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
>
>> From: Zhong Kaihua <zhongkaihua@huawei.com>
>>
>> Add Hi6220 gpio configuration nodes
>>
>> Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
>> Signed-off-by: Kong Xinwei <kong.kongxinwei@hisilicon.com>
>>
>
> Get rid of that blank line.

Will fix.

Sorry missed that in v3.

>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
>
>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> @@ -249,5 +249,264 @@
>>                         clocks = <&ao_ctrl 27>;
>>                         clock-names = "apb_pclk";
>>                 };
>> +
>> +               gpio0: gpio at f8011000 {
>> +                       compatible = "arm,pl061", "arm,primecell";
>> +                       reg = <0x0 0xf8011000 0x0 0x1000>;
>> +                       interrupts = <0 52 0x4>;
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <2>;
>> +                       clocks = <&ao_ctrl 2>;
>> +                       clock-names = "apb_pclk";
>> +                       status = "ok";
>> +               };
>
> This part with all GPIO controllers looks nice.
>
>> new file mode 100644
>> index 0000000..09242f0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
>> @@ -0,0 +1,607 @@
>> +/ {
>> +       gpio_rstout_n:gpio_rstout_n {
>> +               gpios;
>> +       };
>> +       gpio_pmu_peri_en:gpio_pmu_peri_en {
>> +               gpios;
>> +       };
>> +       gpio_sysclk0_en:gpio_sysclk0_en {
>> +               gpios;
>> +       };
>> +       gpio_jtag_tdo:gpio_jtag_tdo {
>> +               gpios;
>> +       };
>> +       /* LCB: PWR_HOLD_GPIO0_0 */
>> +       gpio_pwr_hold:gpio_pwr_hold {
>> +               gpios = <&gpio0 0 0>;
>> +       };
>
> (...)
>
> I don't understand any stuff in this hikey-gpio.dtsi file.
>
> What does all this mean?
>
> If it has any practical use whatsoever then explain it in the
> commit message, but right now it just looks like a big list
> of placeholders with no use, but you can copy-paste them
> into device nodes the day you need them?
>
> If they are unused, just drop this file please.

I will drop this.

Sorry missed this in v2. I will fix this in next version.

-Guodong

>
> Yours,
> Linus Walleij
