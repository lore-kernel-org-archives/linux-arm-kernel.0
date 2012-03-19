From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 19 Mar 2012 15:01:17 +0800
Subject: [PATCH v5 3/4] clk: introduce the common clock framework
In-Reply-To: <CAJOA=zPztBfTY_WDwZ5iFEa94eCtHyrzN422RTACMQXs625gRA@mail.gmail.com>
References: <20120304115201.GB26882@pengutronix.de>
 <CAJOA=zP8d8wm==7=svOzh03Ft-1_LV71q0mA6Pncrh5vQSWGEA@mail.gmail.com>
 <20120305073836.GU3852@pengutronix.de>
 <CAJOA=zMs75ZQ24g5PXpSLV3AJzWEo12g86G8+4+ryQR_cTYpzA@mail.gmail.com>
 <20120306190039.GJ3852@pengutronix.de>
 <CAJOA=zOG_6eSWPEfFL6VKWeTpGKD9y11xeHoOwdS3b59tAZ45A@mail.gmail.com>
 <20120308062739.GE18513@lunn.ch>
 <20120308232549.GU3852@pengutronix.de>
 <20120309075720.GC16608@lunn.ch>
 <CAJOA=zPztBfTY_WDwZ5iFEa94eCtHyrzN422RTACMQXs625gRA@mail.gmail.com>
Message-ID: <20120319070115.GC31410@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 10:25:00AM -0800, Turquette, Mike wrote:
...
> However if you have the ability to use the clk_foo_register functions
> please do use them in place of static initialization.  The static init
> stuff is only for folks backed into a corner and forced to use it...
> for now.  I'm looking at ways to allow for kmalloc'ing in early boot,
> as well as reducing the number of clocks that my platform registers
> during early boot drastically.
> 
While I agree using registration functions rather than static
initialization will help make "struct clk" an opaque cookie, I also
see some benefit with using static initialization over registration
functions.  That is we will be able to initialize parents statically
rather than calling expensive __clk_lookup() to find them when using
registration functions.

I'm not sure if this will be a concern with the platforms that have
hundreds of clocks.  Keep it in mind, when we say one clock, there
are generally 3 clks behind it, clk_gate, clk_divider and clk_mux.

-- 
Regards,
Shawn
