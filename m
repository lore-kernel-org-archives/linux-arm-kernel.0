From: tony@atomide.com (Tony Lindgren)
Date: Sat, 10 Nov 2012 12:04:14 -0800
Subject: [PATCH v4 4/9] ARM: dts: support pinctrl single in pxa910
In-Reply-To: <CAN1soZwDn3VXLCk=-LEVZcZYmRgXEN3WHp74Dr0qRAd83F+tuw@mail.gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-5-git-send-email-haojian.zhuang@gmail.com>
 <20121109224821.GA6801@atomide.com>
 <CAN1soZwDn3VXLCk=-LEVZcZYmRgXEN3WHp74Dr0qRAd83F+tuw@mail.gmail.com>
Message-ID: <20121110200414.GG6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121109 21:38]:
> On Sat, Nov 10, 2012 at 6:48 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > To clarify my binding change comment for the generic pinconf
> > support, here's an example.
> >
> > We need to move pinctrl-single pinconf properties here for
> > each pin group:
> >
> > * Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:21]:
> >> +                             uart1_pins: pinmux_uart1_pins {
> >> +                                     pinctrl-single,pins = <
> >> +                                             0x198 0x6       /* GPIO47_UART1_RXD */
> >> +                                             0x19c 0x6       /* GPIO48_UART1_TXD */
> >> +                                     >;
> >> +                                     pinctrl-single,power-source = <0x2>;
> >> +                                     pinctrl-single,bias = <0x6>;
> >                                         pinctrl-single,power-source-mask = <0x1800>;
> >                                         pinctrl-single,bias-mask = <0xe000>;
> >                                         pinctrl-single,bias-disable = <0>;
> >                                         pinctrl-single,bias-pull-down = <0xa000>;
> >                                         pinctrl-single,bias-pull-up = <0xc000>;
> It's OK.
> 
> >> +                             };
> >
> >
> >
> >> --- a/arch/arm/boot/dts/pxa910.dtsi
> >> +++ b/arch/arm/boot/dts/pxa910.dtsi
> >> @@ -54,6 +54,80 @@
> >>                       reg = <0xd4000000 0x00200000>;
> >>                       ranges;
> >>
> >> +                     pmx: pinmux at d401e000 {
> >> +                             compatible = "pinconf-single";
> >> +                             reg = <0xd401e000 0x0330>;
> >> +                             #address-cells = <1>;
> >> +                             #size-cells = <1>;
> >> +                             ranges;
> >> +
> >> +                             pinctrl-single,register-width = <32>;
> >> +                             pinctrl-single,function-mask = <7>;
> >
> > And then..
> >
> >> +                             pinctrl-single,power-source-mask = <0x1800>;
> >> +                             pinctrl-single,bias-mask = <0xe000>;
> >> +                             pinctrl-single,bias-disable = <0>;
> >> +                             pinctrl-single,bias-pull-down = <0xa000>;
> >> +                             pinctrl-single,bias-pull-up = <0xc000>;
> >> +                             pinctrl-single,input-schmitt-mask = <0x70>;
> >
> > ..remove these from here. Otherwise pinctrl-single,bits type controllers
> > won't be able to use the pinconf functions as we can have multiple pins
> > supported in a single register.
> >
> Will do

OK thanks!

Tony
