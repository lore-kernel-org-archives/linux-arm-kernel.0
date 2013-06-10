From: bjorn@kryo.se (Bjorn Andersson)
Date: Sun, 9 Jun 2013 22:12:11 -0700
Subject: [PATCH 2/2] ARM: nomadik: add the new clocks to the device tree
In-Reply-To: <CAJAp7OiYZx46aWRsXc+CmS+5F0STz5P+rdYnJEoaRRMUnkD1Cg@mail.gmail.com>
References: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
 <1370775348-7440-2-git-send-email-linus.walleij@linaro.org>
 <201306091621.02506.arnd@arndb.de>
 <CAJAp7OiYZx46aWRsXc+CmS+5F0STz5P+rdYnJEoaRRMUnkD1Cg@mail.gmail.com>
Message-ID: <CAJAp7Oji=+9PqwGkF84BRaxkFeeO_kWoY378Ur-A5z6G9Z5xSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While hacking on clock support for msm8960 the other day I did the
same thing; I figured that providing clocks with descriptive names
would be of great benefit while reading the dts.

I had my uart device setup with:
clocks = <&gsbi8_uart_clk>, <&gsbi8_p_clk>;

However, all currently present clock bindings follow the pattern
described by Arnd.
Following this pattern my uart would be setup as:
clocks = <&clks 42>, <&clks 44>;

Needless to say there is no way to make sense of this without
consulting the specific binding documentation. So, although your way
of setting up the clock binding is not the standard way I do prefer
it, but it comes with plenty extra nodes in the tree.

Regards,
Bjorn

On Sun, Jun 9, 2013 at 10:10 PM, Bjorn Andersson <bjorn@kryo.se> wrote:
> Linus,
>
> While hacking on clock support for msm8960 the other day I did the same
> thing; I figured that providing clocks with descriptive names would be of
> great benefit while reading the dts.
>
> I had my uart device setup with:
> clocks = <&gsbi8_uart_clk>, <&gsbi8_p_clk>;
>
> However, all currently present clock bindings seem to follow the pattern
> described by Arnd.
> Following this pattern my uart would be setup as:
> clocks = <&clks 42>, <&clks 44>;
>
> Needless to say there is no way to make sense of this without consulting the
> specific binding documentation. So, although your way of setting up the
> clock binding is not the standard way I do prefer it, but it comes with
> plenty extra nodes in the tree.
>
> Regards,
> Bjorn
>
>
> On Sun, Jun 9, 2013 at 7:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Sunday 09 June 2013, Linus Walleij wrote:
>> > +               /*
>> > +                * IP AMBA bus clocks, driving the bus side of the
>> > +                * peripheral clocking, clock gates.
>> > +                */
>> > +
>> > +               hclkdma0: hclkdma0 at 48M {
>> > +                       #clock-cells = <0>;
>> > +                       compatible = "st,nomadik-src-clock";
>> > +                       clock-id = <0>;
>> > +                       clocks = <&hclk>;
>> > +               };
>> > +               hclksmc: hclksmc at 48M {
>> > +                       #clock-cells = <0>;
>> > +                       compatible = "st,nomadik-src-clock";
>> > +                       clock-id = <1>;
>> > +                       clocks = <&hclk>;
>> > +               };
>> > +               hclksdram: hclksdram at 48M {
>> > +                       #clock-cells = <0>;
>> > +                       compatible = "st,nomadik-src-clock";
>> > +                       clock-id = <2>;
>> > +                       clocks = <&hclk>;
>> > +               };
>> > +               hclkdma1: hclkdma1 at 48M {
>> > +                       #clock-cells = <0>;
>> > +                       compatible = "st,nomadik-src-clock";
>> > +                       clock-id = <3>;
>> > +                       clocks = <&hclk>;
>> > +               };
>>
>> Sorry if I'm being slow to understand how the clock bindings work, but if
>> you have 63 identical clocks that only differ in ther clock-id, can't you
>> just have a single DT node for them instead with #clock-cells=1 to pass
>> the
>> number from the device using it?
>>
>>         Arnd
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
