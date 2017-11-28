From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 28 Nov 2017 08:12:39 +0530
Subject: [PATCH 4/6] SPEAr: clk: pr_err() strings should end with newlines
In-Reply-To: <35a712ed8ee10491c0a605d0cc825250286370a4.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
 <35a712ed8ee10491c0a605d0cc825250286370a4.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171128024239.GD11413@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-11-17, 12:25, Arvind Yadav wrote:
> pr_err() messages should end with a new-line to avoid other messages
> being concatenated.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/clk/spear/clk-gpt-synth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-gpt-synth.c
> index 1a722e9..1cf219a6 100644
> --- a/drivers/clk/spear/clk-gpt-synth.c
> +++ b/drivers/clk/spear/clk-gpt-synth.c
> @@ -120,7 +120,7 @@ struct clk *clk_register_gpt(const char *name, const char *parent_name, unsigned
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
