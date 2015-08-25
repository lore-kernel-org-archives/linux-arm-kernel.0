From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 25 Aug 2015 13:25:51 -0700
Subject: [PATCH v2 1/6] clk: berlin: move MAX_CLKS out of
 drivers/clk/berlin
In-Reply-To: <1439898368-11543-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
 <1439898368-11543-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150825202551.31346.93685@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Antoine Tenart (2015-08-18 04:46:03)
> Move the MAX_CLKS definition used in the Berlin clock driver outside the
> driver.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Michael Turquette <mturquette@baylibre.com>

> ---
>  drivers/clk/berlin/bg2.c             | 1 -
>  drivers/clk/berlin/bg2q.c            | 1 -
>  include/dt-bindings/clock/berlin2.h  | 2 ++
>  include/dt-bindings/clock/berlin2q.h | 2 ++
>  4 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
> index 73153fc45ee9..469a2c57e1b4 100644
> --- a/drivers/clk/berlin/bg2.c
> +++ b/drivers/clk/berlin/bg2.c
> @@ -91,7 +91,6 @@
>   *
>   */
>  
> -#define        MAX_CLKS 41
>  static struct clk *clks[MAX_CLKS];
>  static struct clk_onecell_data clk_data;
>  static DEFINE_SPINLOCK(lock);
> diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
> index 221f40c2b850..a27958efab92 100644
> --- a/drivers/clk/berlin/bg2q.c
> +++ b/drivers/clk/berlin/bg2q.c
> @@ -45,7 +45,6 @@
>  #define REG_SDIO0XIN_CLKCTL    0x0158
>  #define REG_SDIO1XIN_CLKCTL    0x015c
>  
> -#define        MAX_CLKS 27
>  static struct clk *clks[MAX_CLKS];
>  static struct clk_onecell_data clk_data;
>  static DEFINE_SPINLOCK(lock);
> diff --git a/include/dt-bindings/clock/berlin2.h b/include/dt-bindings/clock/berlin2.h
> index 0c30800175df..97832b840beb 100644
> --- a/include/dt-bindings/clock/berlin2.h
> +++ b/include/dt-bindings/clock/berlin2.h
> @@ -43,3 +43,5 @@
>  #define CLKID_VIDEO1           38
>  #define CLKID_VIDEO2           39
>  #define CLKID_TWD              40
> +
> +#define MAX_CLKS               41
> diff --git a/include/dt-bindings/clock/berlin2q.h b/include/dt-bindings/clock/berlin2q.h
> index 287fc3b4afb2..c79af928ae92 100644
> --- a/include/dt-bindings/clock/berlin2q.h
> +++ b/include/dt-bindings/clock/berlin2q.h
> @@ -29,3 +29,5 @@
>  #define CLKID_SMEMC            24
>  #define CLKID_PCIE             25
>  #define CLKID_TWD              26
> +
> +#define MAX_CLKS               27
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
