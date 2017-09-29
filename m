From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 18:31:53 +0800
Subject: [linux-sunxi] Re: [PATCH v2 1/3] ARM: dts: sun8i: Add basic dtsi
 file for Allwinner R40
In-Reply-To: <7F10060D-6A37-4417-9E24-1BB007580126@aosc.io>
References: <20170928092543.45648-1-icenowy@aosc.io>
 <20170928092543.45648-2-icenowy@aosc.io>
 <20170928151103.ov3o5pn5h7inzzan@flea>
 <7F10060D-6A37-4417-9E24-1BB007580126@aosc.io>
Message-ID: <CAGb2v647i7uecshOO=1Pr8U97duSwL_V92GhS3S4J4+0GEkjYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 6:25 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2017?9?28? GMT+08:00 ??11:11:03, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>>Hi,
>>
>>On Thu, Sep 28, 2017 at 09:25:41AM +0000, Icenowy Zheng wrote:
>>> +            /*
>>> +             * The max-frequency properties in all MMC controller nodes
>>> +             * are conservative values proven to work on Banana Pi M2
>>> +             * Ultra (the first community available R40 board).
>>> +             * As the board doesn't wire MMC3 out, the property is not
>>> +             * set in MMC3.
>>> +             * TODO: measure the accurate max frequency of the controllers.
>>> +             */
>>> +            mmc0: mmc at 1c0f000 {
>>> +                    compatible = "allwinner,sun8i-r40-mmc",
>>> +                                 "allwinner,sun50i-a64-mmc";
>>> +                    reg = <0x01c0f000 0x1000>;
>>> +                    clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
>>> +                    clock-names = "ahb", "mmc";
>>> +                    resets = <&ccu RST_BUS_MMC0>;
>>> +                    reset-names = "ahb";
>>> +                    pinctrl-0 = <&mmc0_pins>;
>>> +                    pinctrl-names = "default";
>>> +                    interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>>> +                    max-frequency = <25000000>;
>>> +                    status = "disabled";
>>> +                    #address-cells = <1>;
>>> +                    #size-cells = <0>;
>>> +            };
>>
>>Sorry if it wasn't really clear, but my point was more than you should
>>just drop the max-frequency property
>
> Then set it in the boards' DTS?

Why do you need to set them in the first place? The higher speeds need
voltage control, and the lack of said control means the system won't
use them anyway.

max-frequency would apply better in situations where the board layout
can't guarantee proper signal propagation or timing beyond a certain
frequency. Or if that particular controller instance is flawed or
restricted in some way.


ChenYu
