From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 09:27:45 +0530
Subject: [PATCH 3/9] SPEAr13xx: Add common clock framework support
In-Reply-To: <CAJOA=zOiK30SHGxikLmGzdKN3uUBeB7h65C14PiTjvtJE6B=8Q@mail.gmail.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <4ec83c970099407c938b1308fc25d88061959229.1334942163.git.viresh.kumar@st.com>
 <CAJOA=zOiK30SHGxikLmGzdKN3uUBeB7h65C14PiTjvtJE6B=8Q@mail.gmail.com>
Message-ID: <4F9624B9.4010009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 3:13 AM, Turquette, Mike wrote:
>> > +void __init spear1310_clk_init(void)
>> > +{
>> > +       struct clk *clk, *clk1;
>> > +
>> > +       clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
>> > +       clk_register_clkdev(clk, "apb_pclk", NULL);
> There is no exception handling at all in this function.  Do you just
> expect to fail at some later point?

This is what Russell suggested in his clkdev patch. We don't have to check clk *
returned from clk_register_*(). This will be done in clk_register_clkdev(), clk
lookup wouldn't be registered for failing clocks.

-- 
viresh
