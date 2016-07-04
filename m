From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 4 Jul 2016 12:36:31 +0200
Subject: [PATCH v3] ARM: at91: Document new TCB bindings
In-Reply-To: <20160704122452.69dcddf0@bbrezillon>
References: <1467409925-17761-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160704122452.69dcddf0@bbrezillon>
Message-ID: <20160704103631.GE20045@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2016 at 12:24:52 +0200, Boris Brezillon wrote :
> On Fri,  1 Jul 2016 23:52:05 +0200
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > +One interrupt per TC block:
> > +	tcb0: timer at fff7c000 {
> > +		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		reg = <0xfff7c000 0x100>;
> > +		interrupts = <18 4>;
> > +		clocks = <&tcb0_clk>, <&clk32k>;
> > +		clock-names = "t0_clk", "slow_clk";
> > +
> > +		timer at 0 {
> > +			compatible = "atmel,tcb-timer";
> > +			reg = <0>, <1>;
> > +		};
> > +
> > +		timer at 2 {
> > +			compatible = "atmel,tcb-timer";
> > +			reg = <2>;
> > +		};
> 
> And how can you differentiate the clocksource from the clkevent?
> 

It doesn't really matter actually, I'll do the selection in the driver,
as suggested by Rob.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
