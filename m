From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 07 Nov 2013 18:17:06 +0100
Subject: [PATCH] clk: mvebu: staticize of_cpu_clk_setup
In-Reply-To: <1383814773-5231-1-git-send-email-jszhang@marvell.com>
References: <1383814773-5231-1-git-send-email-jszhang@marvell.com>
Message-ID: <527BCB12.8090501@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2013 09:59, Jisheng Zhang wrote:
> This symbol is used only in this file. The patch fix the following
> sparse warning:
> warning: symbol 'of_cpu_clk_setup' was not declared. Should it be static?
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  drivers/clk/mvebu/clk-cpu.c | 2 +-
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
