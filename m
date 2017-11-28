From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 28 Nov 2017 08:12:25 +0530
Subject: [PATCH 3/6] clk: SPEAr: pr_err() strings should end with newlines
In-Reply-To: <03a5ce213323863375e1fb3f85c0c3cc8c921a41.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
 <03a5ce213323863375e1fb3f85c0c3cc8c921a41.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171128024225.GC11413@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-11-17, 12:25, Arvind Yadav wrote:
> pr_err() messages should end with a new-line to avoid other messages
> being concatenated.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/clk/spear/clk-frac-synth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk-frac-synth.c
> index 58d678b..cbdf43a 100644
> --- a/drivers/clk/spear/clk-frac-synth.c
> +++ b/drivers/clk/spear/clk-frac-synth.c
> @@ -131,7 +131,7 @@ struct clk *clk_register_frac(const char *name, const char *parent_name,
>  	struct clk *clk;
>  
>  	if (!name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
> -		pr_err("Invalid arguments passed");
> +		pr_err("Invalid arguments passed\n");
>  		return ERR_PTR(-EINVAL);
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
