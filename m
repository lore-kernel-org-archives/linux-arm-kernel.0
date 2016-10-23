From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 23 Oct 2016 22:03:23 +0800
Subject: [PATCH] ARM: dts: imx6sx: Fix LCDIF interrupt type
In-Reply-To: <20161002164435.5812-1-marex@denx.de>
References: <20161002164435.5812-1-marex@denx.de>
Message-ID: <20161023140323.GW30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2016 at 06:44:35PM +0200, Marek Vasut wrote:
> The LCDIF interrupt should be triggered by the rising edge of the
> IRQ line because we only want the interrupt to trigger once per each
> frame. It seems the LCDIF IRQ line cannot be explicitly de-asserted
> by software, so the previous behavior before this patch, where the
> interrupt was triggered by level-high status of the IRQ line, caused
> the interrupt to fire again immediatelly after it was handled, which
> caused the system to lock up due to the high rate of interrupts.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>

Applied, thanks.
