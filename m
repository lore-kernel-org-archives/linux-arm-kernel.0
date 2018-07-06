From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Jul 2018 10:55:07 -0700
Subject: [PATCH] clk: aspeed: Support HPLL strapping on ast2400
In-Reply-To: <20180628231540.26633-1-joel@jms.id.au>
References: <20180628231540.26633-1-joel@jms.id.au>
Message-ID: <153089970720.143105.7005759760140367907@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Joel Stanley (2018-06-28 16:15:40)
> The HPLL can be configured through a register (SCU24), however some
> platforms chose to configure it through the strapping settings and do
> not use the register. This was not noticed as the logic for bit 18 in
> SCU24 was confused: set means programmed, but the driver read it as set
> means strapped.
> 
> This gives us the correct HPLL value on Palmetto systems, from which
> most of the peripheral clocks are generated.
> 
> Fixes: 5eda5d79e4be ("clk: Add clock driver for ASPEED BMC SoCs")
> Cc: stable at vger.kernel.org # v4.15
> Reviewed-by: C?dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Do you want this merged for -rc5? It sounds like on some systems this is
a problem, but I don't know if these systems are supposed to work yet or
not, so priority of this fix is not easy for me to understand.
