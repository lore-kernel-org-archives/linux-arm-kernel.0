From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jan 2012 16:21:40 +0800
Subject: MX28 fec clock frequency
In-Reply-To: <4F0AF4B0.4030403@prolan.hu>
References: <4F06D643.6080602@prolan.hu>
 <20120108033238.GA19721@S2101-09.ap.freescale.net>
 <4F0AF4B0.4030403@prolan.hu>
Message-ID: <20120110082138.GF23362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 03:07:44PM +0100, Peter Rusko wrote:
> +	/* ENET_CLK setup */
> +	enet_clk.set_parent(&enet_clk, &pll0_clk);
> +	__raw_writel(BF_CLKCTRL_ENET_DIV(12),
> +		       	CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
> +
I'm not sure it's causing the problem you are seeing.  But from i.MX28
spec, it seems that bit BUSY_TIME of register HW_CLKCTRL_ENET should
be polled for new divider setting?

-- 
Regards,
Shawn
