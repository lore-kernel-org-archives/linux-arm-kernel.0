From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Jan 2012 09:43:23 -0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120130021041.GB10470@S2101-09.ap.freescale.net>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <20120123210052.GS22818@atomide.com>
 <20120126093610.GD2287@S2101-09.ap.freescale.net>
 <20120126175122.GX22818@atomide.com>
 <20120127071944.GC32740@S2101-09.ap.freescale.net>
 <20120127171653.GI13504@atomide.com>
 <20120130021041.GB10470@S2101-09.ap.freescale.net>
Message-ID: <20120130174323.GF9339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo <shawn.guo@linaro.org> [120129 17:27]:
> On Fri, Jan 27, 2012 at 09:16:53AM -0800, Tony Lindgren wrote:
> ...
> > I guess the analog we should follow here is clk_get and clk_set_rate,
> > except we would have pinconf_set_state with predefined states.
> > 
> It seems working for cases that we only change pinconf but never pinmux
> for different configuration states.  But how would that work for cases
> that require mux change for different configuration states?

I don't see why we should not allow changing the mux state with pinconf
too, after all it's the mux/pin that's locked, not the functionality of
the pin.

An example of this would be remuxing a shared UART line between rx and
tx. Those kind of cases could be defined as PMX_DIRECTION_INPUT and
PMX_DIRECTION_OUTPUT so driver could call Linux generic functions for
those if implemented.

Regards,

Tony
