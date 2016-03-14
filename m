From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Mar 2016 08:56:59 +0900
Subject: [PATCH 1/2] ARM: dts: r8a7794: add CAN clocks to device tree
In-Reply-To: <CAMuHMdUWN9UVsDFxRCH6b+i7ERP5-W5wc6oU+OjYi=VYXS6UCQ@mail.gmail.com>
References: <1457922543-20975-1-git-send-email-horms+renesas@verge.net.au>
 <1457922543-20975-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUWN9UVsDFxRCH6b+i7ERP5-W5wc6oU+OjYi=VYXS6UCQ@mail.gmail.com>
Message-ID: <20160314235659.GA23279@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 10:23:01AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Mar 14, 2016 at 3:29 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > --- a/arch/arm/boot/dts/r8a7794.dtsi
> > +++ b/arch/arm/boot/dts/r8a7794.dtsi
> > @@ -844,6 +844,24 @@
> >                         clock-output-names = "extal";
> >                 };
> >
> > +               /* External USB clock - can be overridden by the board */
> > +               usb_extal_clk: usb_extal_clk {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <48000000>;
> > +                       clock-output-names = "usb_extal";
> 
> "clock-output-names" is optional these days, so please drop it.

Thanks, I will drop it from this patch.

Do we have a plan to remove it from existing nodes?
Should I do a sweep of the Renesas DTS files?
And in particular, should it be removed from cpg_clocks ?

> The clock will be named after the node name, so please rename it to
> "usb_extal".

Thanks, will do.
Likewise for the changes requested below.

> > +               };
> > +
> > +               /* External CAN clock */
> > +               can_clk: can_clk {
> 
> can_clk: can {
> 
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       /* This value must be overridden by the board. */
> > +                       clock-frequency = <0>;
> > +                       clock-output-names = "can_clk";
> 
> Likewise.
> 
> > +                       status = "disabled";
> > +               };
