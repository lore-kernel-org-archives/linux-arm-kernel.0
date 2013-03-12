From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 12 Mar 2013 10:00:06 +0800
Subject: [PATCH] clk: prima2: fix return value check in
 sirfsoc_of_clk_init()
In-Reply-To: <CAPgLHd82XEZEP4eDvmvPjdHHz6u40+16W1GZeCWWw6Cj3SAwCg@mail.gmail.com>
References: <CAPgLHd82XEZEP4eDvmvPjdHHz6u40+16W1GZeCWWw6Cj3SAwCg@mail.gmail.com>
Message-ID: <CAGsJ_4ykNjO9rxB9_THY8Vb+Q7aYZiwDxjA=EWOOSumZmtHtnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/11 Wei Yongjun <weiyj.lk@gmail.com>:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function clk_get() returns ERR_PTR()
> not NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked. Thanks!

> ---
>  drivers/clk/clk-prima2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-prima2.c b/drivers/clk/clk-prima2.c
> index f8e9d0c..b208665 100644
> --- a/drivers/clk/clk-prima2.c
> +++ b/drivers/clk/clk-prima2.c
> @@ -1113,7 +1113,7 @@ void __init sirfsoc_of_clk_init(void)
>
>         for (i = pll1; i < maxclk; i++) {
>                 prima2_clks[i] = clk_register(NULL, prima2_clk_hw_array[i]);
> -               BUG_ON(!prima2_clks[i]);
> +               BUG_ON(IS_ERR(prima2_clks[i]);
>         }
>         clk_register_clkdev(prima2_clks[cpu], NULL, "cpu");
>         clk_register_clkdev(prima2_clks[io],  NULL, "io");
>

-barry
