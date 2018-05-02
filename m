From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Wed, 2 May 2018 17:20:19 +0530
Subject: [linux-sunxi] Re: [PATCH 02/21] arm64: dts: allwinner: a64: Add
 DE2 CCU
In-Reply-To: <DF02AB5F-D4A5-4198-B455-FEE880CF83CE@aosc.io>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-3-jagan@amarulasolutions.com>
 <20180502113250.5i2eyzv237t5oyl6@flea>
 <DF02AB5F-D4A5-4198-B455-FEE880CF83CE@aosc.io>
Message-ID: <CAD6G_RQ3HmHBjwcUoCCth5TwVy5ygx_KwRmRjrkpwoOpvy7vvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2018 at 5:04 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2018?5?2? GMT+08:00 ??7:32:50, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>>On Mon, Apr 30, 2018 at 05:10:39PM +0530, Jagan Teki wrote:
>>> DE2 in A64 has clock control unit and behavior is
>>> same like H3/H5, so reuse the same in A64.
>>>
>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>> ---
>>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> index 1b2ef28c42bd..67b80bbe5bf5 100644
>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> @@ -43,9 +43,11 @@
>>>   */
>>>
>>>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
>>> +#include <dt-bindings/clock/sun8i-de2.h>
>>>  #include <dt-bindings/clock/sun8i-r-ccu.h>
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/reset/sun50i-a64-ccu.h>
>>> +#include <dt-bindings/reset/sun8i-de2.h>
>>>
>>>  / {
>>>      interrupt-parent = <&gic>;
>>> @@ -168,6 +170,19 @@
>>>              #size-cells = <1>;
>>>              ranges;
>>>
>>> +            display_clocks: clock at 1000000 {
>>> +                    compatible = "allwinner,sun50i-a64-de2-clk",
>>> +                                 "allwinner,sun50i-h5-de2-clk";
>>
>>The A64 was released before the H5, so that should be the other way
>>around.
>>
>>> +                    reg = <0x01000000 0x100000>;
>>> +                    clocks = <&ccu CLK_DE>,
>>> +                             <&ccu CLK_BUS_DE>;
>>> +                    clock-names = "mod",
>>> +                                  "bus";
>>> +                    resets = <&ccu RST_BUS_DE>;
>>> +                    #clock-cells = <1>;
>>> +                    #reset-cells = <1>;
>>> +            };
>>> +
>>
>>So it turns out we don't need the SRAM to access the CCU driver?
>
> As now U-Boot claims SRAM, people may forget thus :-(

I've sent few mails about how we represent de2 with sram_c [1] but
none response after. Can I get further inputs so-that we can include
sram_c in proper manner.

[1] https://patchwork.kernel.org/patch/10289737/

Jagan.
