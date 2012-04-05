From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Apr 2012 11:58:35 +0200
Subject: Query: clk: Defining new struct clk_foo types
In-Reply-To: <4F7D443E.3010800@st.com>
References: <4F7D443E.3010800@st.com>
Message-ID: <20120405095835.GB20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 12:35:34PM +0530, Viresh Kumar wrote:
> Hi Mike,
> 
> I am doing SPEAr SoCs clock port with common clock framework.
> 
> Currently there are following type of clk_foo implementations present:
> - clk_gate
> - clk_divider
> - clk_fixed_rate
> - clk_mux
> 
> I have few more in my SoC:
> clk with:
> - gate + divider
> - gate + fixed_rate
> - gate + mux
> ...
> 
> How should i go ahead in my implementation for these?
> Should i create SPEAr specific structures or enhance drivers/clk for this?

If you have a gate and a divider then register a gate and a divider.
We don't need clk providers for combination of these, the clock
framework will handle it just fine.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
