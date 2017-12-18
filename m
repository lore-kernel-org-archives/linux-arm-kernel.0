From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Dec 2017 09:12:38 -0800
Subject: [PATCH 1/3] dt-bindings: chosen: Add clocksource and clockevent
 selection
In-Reply-To: <8fe1dce0-3fd2-d740-8456-bf3b734e571a@ti.com>
References: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
 <20171213185313.20017-2-alexandre.belloni@free-electrons.com>
 <8fe1dce0-3fd2-d740-8456-bf3b734e571a@ti.com>
Message-ID: <20171218171238.GK3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [171216 01:59]:
> On 12/13/2017 12:53 PM, Alexandre Belloni wrote:
> > +/ {
> > +	chosen {
> > +		linux,clocksource {
> > +			timer = <&timer0>;
> > +		};
> > +
> > +		linux,clockevent {
> > +			timer = <&timer1>;
> > +		};
> > +	};
> > +};
> > 
> 
> It'd be nice if smth. like this will actually happen, as on some OMAP
> platforms can be up to 3-4 alternatives for each clocksource/clockevent and
> different combination need to be selected depending on SoC and platform
> (and sometime - use case) which is pain in multi-platform environment now.

Yeah agreed.

> But more important note from my side is clocksource and clockevent selections seems 
> not enough :( There are also sched clock (sched_clock_register()) and delay_timer
>  (register_current_timer_delay() at least on ARM).
> Both above can't be unregistered (at least last time I've checked).

So maybe they should be also defined the sam way as above or is
there something more to it?

Regards,

Tony
