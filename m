From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 17:13:49 +0800
Subject: [PATCH 1/5] ARM: imx: add more imx5 ssi clocks
In-Reply-To: <20120511074222.GC27341@pengutronix.de>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-2-git-send-email-shawn.guo@linaro.org>
 <20120511074222.GC27341@pengutronix.de>
Message-ID: <20120511091347.GY17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 09:42:22AM +0200, Sascha Hauer wrote:
> > +	clk_register_clkdev(clk[ssi_ext1_gate], NULL, "ssi_ext.0");
> > +	clk_register_clkdev(clk[ssi_ext2_gate], NULL, "ssi_ext.1");
> 
> At some point I'd like to be able to lookup a clk based on its clkname,
> given that they have a unique name anyway. The clkdev mechanism does a
> good job in associating devices with clocks, but it's not very suitable
> to manipulate the clock tree like you want to do here.
> 
I'm fine with that.  But last time, you add clkname into struct
clk_lookup, I have seen some comments against that.  But let's see.

> We could simply do a
> 
> 	for_each_clk() {
> 		clk_register_clkdev(clk, NULL, clk->name);
> 	}
> 
> This at least would prevent us from adding a new clkdev each time
> somebody wants to do some fixups to the clock tree. I don't know if any
> plans are existing to do something like this directly in the clock
> framework instead.
> 
I think this has to be get done at framework level, as clk->name is not
accessible in clock provider, unless we include clk-private.h.

-- 
Regards,
Shawn
