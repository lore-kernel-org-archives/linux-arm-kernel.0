From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 28 Jan 2013 09:18:08 +0000
Subject: [PATCH v2 1/2] clk: divider: prepare for minimum divider
In-Reply-To: <20130125223524.10623.29375@quantum>
References: <6dc1c48cac5b2646a55da3079afb72f88e40c3bc.1358937138.git.afzal@ti.com>
 <20130123214053.9205.49804@quantum>
 <C8443D0743D26F4388EA172BF4E2A7A93EA92ABC@DBDE01.ent.ti.com>
 <20130124170630.10623.78749@quantum>
 <C8443D0743D26F4388EA172BF4E2A7A93EA93851@DBDE01.ent.ti.com>
 <20130125223524.10623.29375@quantum>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA943FA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Sat, Jan 26, 2013 at 04:05:24, Mike Turquette wrote:

> Thank you for the information.  In short, the way you program your clock
> depend on the configuration of your lcdc device.
> 
> As such I am not sure the basic divider is the right choice for you.
> You might be better off creating a clock for your IP which takes into
> account these details.  Luckily it is possible to inherit from the basic
> clock types and create a new type.
> 
> An example of this is the MXS divider.  It uses the basic divider as a
> "parent class" and adds a busy bit.  This is a better approach than
> putting every feature into the basic divider type.  You can see how it
> was done in drivers/clk/mxs/clk-div.c
> 
> Let me know what you think.

Yes, a derived divider is better.

As mentioned in other thread, the modeling of clock nodes (derived plus
gates) would bring in considerable (relative to complete driver) code, the
advantage being higher pixel clock resolution. Current use cases work
as per existing divider setting in driver. Hence now it seems a better
decision now is to proceed with logic as in v2 (not using clock nodes).
And later depending on the use case requirement, clock tree modeling can
be implemented.

Thanks for your input.

Regards
Afzal
