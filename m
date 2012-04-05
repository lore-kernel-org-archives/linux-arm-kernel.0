From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 Apr 2012 15:43:49 +0530
Subject: Query: clk: Defining new struct clk_foo types
In-Reply-To: <20120405095835.GB20478@pengutronix.de>
References: <4F7D443E.3010800@st.com> <20120405095835.GB20478@pengutronix.de>
Message-ID: <4F7D705D.7050004@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/2012 3:28 PM, Sascha Hauer wrote:
> If you have a gate and a divider then register a gate and a divider.
> We don't need clk providers for combination of these, the clock
> framework will handle it just fine.

Thanks Sashca, but i didn't get your reply completely.
Lets see if i can understand it with help of an example:

I have uart's clock that can be gated and its rate derived as a divider.
So to define static clock structures, i do following:

DEFINE_CLK_GATE(uart_gate_clk, "uart_parent", &uart_parent_clk,	0,
	0xd0000000, 5, 0, NULL);
DEFINE_CLK_DIVIDER(uart_divider_clk, "uart_parent", &uart_parent_clk,
	0, 0xd0000080, 4, 2, 0, NULL);

You are suggesting this?

If yes, I don't know how it will work. How will clk get work
with dev_id: "uart0". Which one will it pick?

Confused. :(

-- 
viresh
