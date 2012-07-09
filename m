From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 9 Jul 2012 11:57:40 +0100
Subject: [PATCH 3/6] clk: SPEAr13xx: Add localtimer (twd) clock support
In-Reply-To: <1341829866-26091-3-git-send-email-shiraz.hashim@st.com>
References: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
 <1341829866-26091-3-git-send-email-shiraz.hashim@st.com>
Message-ID: <CAOh2x=mMeGExE6JaP_Ou614X3btqDsUW3_NFdgQx8a6hPdS+7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2012 at 11:31 AM, Shiraz Hashim <shiraz.hashim@st.com> wrote:
> From: Vipul Kumar Samar <vipulkumar.samar@st.com>
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> ---
>  drivers/clk/spear/spear1310_clock.c |    4 ++++
>  drivers/clk/spear/spear1340_clock.c |    4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
> index 8f05652..3a246b4 100644
> --- a/drivers/clk/spear/spear1310_clock.c
> +++ b/drivers/clk/spear/spear1310_clock.c
> @@ -491,6 +491,10 @@ void __init spear1310_clk_init(void)
>                         2);
>         clk_register_clkdev(clk, NULL, "ec800620.wdt");
>
> +       clk = clk_register_fixed_factor(NULL, "smp_twd_clk", "cpu_clk", 0, 1,
> +                       2);
> +       clk_register_clkdev(clk, NULL, "smp_twd");
> +
>         clk = clk_register_fixed_factor(NULL, "ahb_clk", "pll1_clk", 0, 1,
>                         6);
>         clk_register_clkdev(clk, "ahb_clk", NULL);
> diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
> index d77f54f..a7d5d32 100644
> --- a/drivers/clk/spear/spear1340_clock.c
> +++ b/drivers/clk/spear/spear1340_clock.c
> @@ -537,6 +537,10 @@ void __init spear1340_clk_init(void)
>                         2);
>         clk_register_clkdev(clk, NULL, "ec800620.wdt");
>
> +       clk = clk_register_fixed_factor(NULL, "smp_twd_clk", "cpu_clk", 0, 1,
> +                       2);
> +       clk_register_clkdev(clk, NULL, "smp_twd");
> +
>         clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
>                         ARRAY_SIZE(ahb_parents), 0, SPEAR1340_SYS_CLK_CTRL,
>                         SPEAR1340_HCLK_SRC_SEL_SHIFT,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
