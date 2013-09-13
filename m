From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 13 Sep 2013 11:52:20 +0200
Subject: [PATCH 07/10] clk: mvebu: Staticize of_cpu_clk_setup
In-Reply-To: <1379064232-10261-7-git-send-email-sachin.kamat@linaro.org>
References: <1379064232-10261-1-git-send-email-sachin.kamat@linaro.org>
 <1379064232-10261-7-git-send-email-sachin.kamat@linaro.org>
Message-ID: <5232E054.7010802@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/09/2013 11:23, Sachin Kamat wrote:
> 'of_cpu_clk_setup' is used only in this file. Make it static.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>

Good catch, it should have been part of the "f640c0f clk: mvebu: Use
common of_clk_init() function" commit.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> ---
>  drivers/clk/mvebu/clk-cpu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
> index 1466865..8ebf757 100644
> --- a/drivers/clk/mvebu/clk-cpu.c
> +++ b/drivers/clk/mvebu/clk-cpu.c
> @@ -101,7 +101,7 @@ static const struct clk_ops cpu_ops = {
>  	.set_rate = clk_cpu_set_rate,
>  };
>  
> -void __init of_cpu_clk_setup(struct device_node *node)
> +static void __init of_cpu_clk_setup(struct device_node *node)
>  {
>  	struct cpu_clk *cpuclk;
>  	void __iomem *clock_complex_base = of_iomap(node, 0);
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
