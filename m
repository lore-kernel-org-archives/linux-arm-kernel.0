From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 14:10:22 -0800
Subject: [PATCHv2] clk: ti: omap3+: dpll: use non-locking version of
 clk_get_rate
In-Reply-To: <20160222220514.GZ4847@codeaurora.org>
References: <1455966777-30576-1-git-send-email-t-kristo@ti.com>
 <20160222165252.GF13417@atomide.com>
 <20160222220514.GZ4847@codeaurora.org>
Message-ID: <20160222221021.GW13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Boyd <sboyd@codeaurora.org> [160222 14:05]:
> On 02/22, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [160220 03:12]:
> > > As the code in this file is being executed within irq context in some
> > > cases, we must avoid the clk_get_rate which uses mutex internally.
> > > Switch the code to use clk_hw_get_rate instead which is non-locking.
> > > 
> > > This fixes an issue where PM runtime will hang the system if enabled
> > > with a serial console before a suspend-resume cycle.
> > 
> > Can you please add the "Fixes: " line here?
> > 
> > And when applying, please tag this one Cc stable.
> > 
> > Other than that, please feel free to add:
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > 
> 
> This is what I got. "Fixes" should take care of stable.

OK thanks!

Tony
