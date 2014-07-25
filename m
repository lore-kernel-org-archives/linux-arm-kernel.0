From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 25 Jul 2014 12:39:06 -0700
Subject: [PATCH v2 6/7] ARM: dts: rockchip: add core rk3288 dtsi
In-Reply-To: <CAD=FV=X9Ym_1-mweR2fBNwPhfbMVUu+EKO+qsY=te+=-pUDhcw@mail.gmail.com>
References: <4868343.UFgjaXesOn@diego> <14646641.DlFrJR068n@diego>
 <CAD=FV=X9Ym_1-mweR2fBNwPhfbMVUu+EKO+qsY=te+=-pUDhcw@mail.gmail.com>
Message-ID: <20140725193906.22930.61548@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Doug Anderson (2014-07-24 16:06:34)
> > +       xin24m: xin24m {
> > +               compatible = "fixed-clock";
> > +               clock-frequency = <24000000>;
> > +               #clock-cells = <0>;
> > +       };
> 
> I'm no expert, but strangely every other .dts seems to have the clocks
> under a "clocks" node.  That seems to contradict the suggestion made
> previously that things should not be on the top level, though.

That usually happens when there is a clock controller (e.g. "clocks")
that has multiple clock signals coming out of it. Typically this is for
a clock generator IP within a SoC or other chip.

However for a single board-level clock such as an osc then it is common
to put it at a top-level for that board since these can change from
board to board.

> 
> Also, _I think_ device tree suggests a more generic name for the node
> like "oscillator".  You could use "xin24m" as an output name, I think.
> Mike could correct me if I'm wrong.

You are correct.

Regards,
Mike
