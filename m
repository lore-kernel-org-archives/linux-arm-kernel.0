From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Mar 2018 22:33:04 +0100
Subject: [PATCH v2 4/4] clk: imx: add clock driver for i.MX8MQ CCM
In-Reply-To: <20180201175412.9480-4-l.stach@pengutronix.de>
References: <20180201175412.9480-1-l.stach@pengutronix.de>
 <20180201175412.9480-4-l.stach@pengutronix.de>
Message-ID: <20180315213304.ejvgpkhxtblr6xb3@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 06:54:12PM +0100, Lucas Stach wrote:
> Add driver for the Clock Control Module found on i.MX8MQ.
> 
> This is largely based on the downstream driver from Anson Huang and
> Bai Ping at NXP, with only some small adaptions to mainline from me.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

A general thought: The i.MX8M finally has a consistent clock tree. We
have for example 70 Peripheral clock slices consisting of a mux, a gate
and two dividers, all 70 looking the same.
For these it might make sense to create a more complex clock type
providing mux, gate and set rate functionality in one clock. This would
drastically reduce the number of clocks we have to handle.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
