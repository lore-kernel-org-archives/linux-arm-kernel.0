From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Apr 2015 14:52:20 +0200
Subject: [PATCH 1/3] ARM: dts: sunxi: A10s Olinuxino add missing SPI and
 simplefb.
In-Reply-To: <CAOMqctTKoDeLqii7YEEv80B+Ru4tsVwiGYB0-u7XLPqNoEiCTQ@mail.gmail.com>
References: <cover.1430034797.git.hramrach@gmail.com>
 <f6e34cb3f0b72fcb0ae18ccf96962fb8a1c477f7.1430034797.git.hramrach@gmail.com>
 <20150426083958.GD5627@lukather>
 <CAOMqctTKoDeLqii7YEEv80B+Ru4tsVwiGYB0-u7XLPqNoEiCTQ@mail.gmail.com>
Message-ID: <20150426125220.GG5627@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 26, 2015 at 11:21:34AM +0200, Michal Suchanek wrote:
> Hello,
> 
> On 26 April 2015 at 10:39, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Mon, Mar 23, 2015 at 03:00:31PM +0100, Michal Suchanek wrote:
> >> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> 
> >>  &ohci0 {
> >>       status = "okay";
> >>  };
> >> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> >> index a78c95d..438eba1 100644
> >> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> >> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> >> @@ -154,6 +154,20 @@
> >>                       clocks = <&apb1_gates 18>;
> >>                       status = "disabled";
> >>               };
> >> +
> >> +             spi2: spi at 01c17000 {
> >> +                     compatible = "allwinner,sun4i-a10-spi";
> >> +                     reg = <0x01c17000 0x1000>;
> >> +                     interrupts = <12>;
> >> +                     clocks = <&ahb_gates 22>, <&spi2_clk>;
> >> +                     clock-names = "ahb", "mod";
> >> +                     dmas = <&dma SUN4I_DMA_DEDICATED 29>,
> >> +                            <&dma SUN4I_DMA_DEDICATED 28>;
> >> +                     dma-names = "rx", "tx";
> >> +                     status = "disabled";
> >> +                     #address-cells = <1>;
> >> +                     #size-cells = <0>;
> >> +             };
> >>       };
> >>  };
> >
> > This should be in sun5i.dtsi (and in a separate patch).
> >
> >> @@ -198,4 +212,18 @@
> >>               allwinner,drive = <SUN4I_PINCTRL_30_MA>;
> >>               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >>       };
> >> +
> >> +     spi2_pins_a: spi2 at 0 {
> >> +             allwinner,pins = "PB11", "PB12", "PB13", "PB14";
> >> +             allwinner,function = "spi2";
> >> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +     };
> >> +
> >> +     spi2_pins_b: spi2 at 1 {
> >> +             allwinner,pins = "PE00", "PE01", "PE02", "PE03";
> >> +             allwinner,function = "spi2";
> >> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +     };
> >>  };
> >
> > Ditto.
> >
> 
> A13 does not have these pins so maybe not?

A13 has the PE* pins, but yeah, that's true for the first group.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150426/62f0eeab/attachment-0001.sig>
