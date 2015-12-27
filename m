From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Dec 2015 22:20:59 +0100
Subject: [PATCH v3 2/3] ARM: dts: sun8i: Add Allwinner A83T dtsi
In-Reply-To: <CAEzqOZuVdLS+b9KO9YPgAFiQhXg9KfkmA0i5AEPQPUaben0GCQ@mail.gmail.com>
References: <1450445451-311-1-git-send-email-vishnupatekar0510@gmail.com>
 <1450445451-311-3-git-send-email-vishnupatekar0510@gmail.com>
 <20151218214112.GU30359@lukather>
 <CAEzqOZuVdLS+b9KO9YPgAFiQhXg9KfkmA0i5AEPQPUaben0GCQ@mail.gmail.com>
Message-ID: <20151227212059.GN30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 05:41:22PM +0800, Vishnu Patekar wrote:
> >> +     clocks {
> >> +             #address-cells = <1>;
> >> +             #size-cells = <1>;
> >> +             ranges;
> >> +
> >> +             osc24M: osc24M_clk {
> >> +                     #clock-cells = <0>;
> >> +                     compatible = "fixed-clock";
> >> +                     clock-frequency = <24000000>;
> >> +                     clock-output-names = "osc24M";
> >> +             };
> >> +
> >> +             osc32k: osc32k_clk {
> >> +                     #clock-cells = <0>;
> >> +                     compatible = "fixed-clock";
> >> +                     clock-frequency = <32768>;
> >> +                     clock-output-names = "osc32k";
> >> +             };
> >
> > Do you need to modify the clocks driver in your first commit then?
> I did not get what you are trying to say here, could you please elaborate?
> 
> I'll correct mistakes, and re-send this patch, is it okie?

In your first patch, you add a CLK_OF_DECLARE for the H3 compatible in
clk-sunxi.c

Judging from your clocks node above, you don't need it at all.

I'm guessing you'll need it later on, but I wanted to know if that was
intentional :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151227/8f055c2e/attachment.sig>
