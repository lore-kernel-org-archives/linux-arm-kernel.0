From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Jun 2016 15:08:11 -0500
Subject: [PATCH 02/48] ARM: at91: Document new TCB bindings
In-Reply-To: <20160615092955.261f14fb@bbrezillon>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20160614214737.GA10294@rob-hp-laptop>
 <20160615092955.261f14fb@bbrezillon>
Message-ID: <20160621200811.GA22435@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 09:29:55AM +0200, Boris Brezillon wrote:
> On Tue, 14 Jun 2016 16:47:37 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sat, Jun 11, 2016 at 12:03:05AM +0200, Alexandre Belloni wrote:
> > > The current binding for the TCB is not flexible enough for some use cases
> > > and prevents proper utilization of all the channels.
> > > 
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: linux-pwm at vger.kernel.org
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: devicetree at vger.kernel.org
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > ---
> > >  .../devicetree/bindings/arm/atmel-at91.txt         | 32 -----------
> > >  .../devicetree/bindings/mfd/atmel-tcb.txt          | 62 ++++++++++++++++++++++
> > >  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      | 12 +++--
> > >  3 files changed, 69 insertions(+), 37 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt  
> > 
> > [...]
> > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> > > new file mode 100644
> > > index 000000000000..48196752c78f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> > > @@ -0,0 +1,62 @@
> > > +* Device tree bindings for Atmel Timer Counter Blocks
> > > +- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
> > > +  <chip> can be "at91rm9200" or "at91sam9x5"
> > > +- reg: Should contain registers location and length
> > > +- #address-cells: has to be 1
> > > +- #size-cells: has to be 0
> > > +- interrupts: Should contain all interrupts for the TC block
> > > +  Note that you can specify several interrupt cells if the TC
> > > +  block has one interrupt per channel.
> > > +- clock-names: tuple listing input clock names.
> > > +	Required elements: "t0_clk", "slow_clk"
> > > +	Optional elements: "t1_clk", "t2_clk"
> > > +- clocks: phandles to input clocks.  
> > 
> > What is the order of clocks?
> > 
> > > +
> > > +The TCB can expose multiple subdevices:
> > > + * a clocksource and clockevent device  
> > 
> > No. These compatible names are linuxisms. Describe features of the 
> > timers to be able to select which timer to use if you need to pick 
> > certain timers. For example, interrupt capability could be used to 
> > select the clkevt.
> 
> Would 'atmel,tcb-free-running-timer' (to replace 'atmel,tcb-clksrc') and
> 'atmel,tcb-programmable-timer' (to replace 'atmel,tcb-clkevt') be
> acceptable?

If that somehow matches the documentation or accurately describes the 
h/w capabilities for them, then yes.

Rob
