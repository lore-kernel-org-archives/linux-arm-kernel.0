From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Jul 2014 23:08:28 +0800
Subject: [PATCH] arm: clk-imx6q: parent lvds_sel input from upstream
 clock gates
In-Reply-To: <1405592414-19550-1-git-send-email-l.stach@pengutronix.de>
References: <1405592414-19550-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140717150826.GT2197@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 12:20:14PM +0200, Lucas Stach wrote:
> The i.MX6 reference manual doesn't make a clear distinction
> between the fixed clock divider and the enable gate for the
> pcie and sata reference clocks. This lead to the lvds mux
> inputs in the imx6q clk driver to be parented from the
> ref clock (which is the divider) instead of the actual gate,
> which in turn prevents the upstream clock to actually be
> enabled when lvds clk out is active.
> 
> This fixes a hard machine hang regression in kernel 3.16 for
> boards where only pcie is active but no sata, as with this
> kernel version the imx6-pcie driver is no longer enabling
> the upstream clock directly but only lvds clk out.
> 
> Reported-by: Arne Ruhnau <arne.ruhnau@target-sg.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Arne Ruhnau <arne.ruhnau@target-sg.com>
> ---
> Shawn, this is an urgent fix for 3.16. Can you please
> Ack it so arm-soc people can take this directly?
> ---

Acked-by: Shawn Guo <shawn.guo@freescale.com>

It will conflict with the patch switching to use macro for clock IDs,
which I'm about to send for 3.17, though.

Shawn
