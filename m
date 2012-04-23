From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 23 Apr 2012 14:43:27 -0700
Subject: [PATCH 3/9] SPEAr13xx: Add common clock framework support
In-Reply-To: <4ec83c970099407c938b1308fc25d88061959229.1334942163.git.viresh.kumar@st.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <4ec83c970099407c938b1308fc25d88061959229.1334942163.git.viresh.kumar@st.com>
Message-ID: <CAJOA=zOiK30SHGxikLmGzdKN3uUBeB7h65C14PiTjvtJE6B=8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 10:22 AM, Viresh Kumar <viresh.linux@gmail.com> wrote:
> This patch adds SPEAr1310 and SPEAr1340's clock framework support. It is based
> on earlier support for SPEAr3xx family.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Cc: Mike Turquette <mturquette@ti.com>
> ---
> Mike,
>
> This would be required to go through Arnd's tree. So would be great if i can
> have your comments/Ack here.

Most of this patch looks good to me accept for the two items below:

...

> +void __init spear1310_clk_init(void)
> +{
> + ? ? ? struct clk *clk, *clk1;
> +
> + ? ? ? clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
> + ? ? ? clk_register_clkdev(clk, "apb_pclk", NULL);

There is no exception handling at all in this function.  Do you just
expect to fail at some later point?

...

> +void __init spear1340_clk_init(void)
> +{
> + ? ? ? struct clk *clk, *clk1;
> +
> + ? ? ? clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
> + ? ? ? clk_register_clkdev(clk, "apb_pclk", NULL);

Ditto.

Regards,
Mike
