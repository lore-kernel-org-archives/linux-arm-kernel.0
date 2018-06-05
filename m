From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Jun 2018 07:14:30 -0700
Subject: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
In-Reply-To: <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
Message-ID: <20180605141430.GE5738@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh+dt@kernel.org> [180605 14:08]:
> On Tue, Jun 5, 2018 at 1:05 AM, Nishanth Menon <nm@ti.com> wrote:
> > +       soc0: soc0 {
> > +               compatible = "simple-bus";
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> 
> Really need 64-bit addresses and sizes? Use ranges to limit the
> address space if possible.

And in addition to using ranges, please set up separate bus instances
for the interconnects. This will then allow you to probe WKUP or
similar instance first and the other bus instances after. And that
pretty much allows you to get rid of the annoying -EPROBE_DEFER
ping pong and allows making clocks proper device drivers ;)

Regards,

Tony
