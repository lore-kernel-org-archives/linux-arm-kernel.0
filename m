From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 01 May 2014 16:14:35 +0100
Subject: [PATCH] vexpress: Initialise the sysregs before setting up the
 clocks
In-Reply-To: <1398953107-29426-1-git-send-email-catalin.marinas@arm.com>
References: <1398953107-29426-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1398957275.3452.69.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-05-01 at 15:05 +0100, Catalin Marinas wrote:
[...]
> In addition, vexpress_sysreg_init() is changed to a device_initcall()

Not in this patch it isn't ;-)

>  as the core_initcall() is no longer
> required.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Pawel Moll <pawel.moll@arm.com>
> Acked-by: Pawel Moll <pawel.moll@arm.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
> 
> Mike, I'd like to get this in for 3.15 and I'm happy to push it via the arm64
> tree. Are you ok with this? Thanks.
> 
>  drivers/clk/versatile/clk-vexpress-osc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
> index a535c7bf8574..422391242b39 100644
> --- a/drivers/clk/versatile/clk-vexpress-osc.c
> +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> @@ -100,6 +100,8 @@ void __init vexpress_osc_of_setup(struct device_node *node)
>  	struct clk *clk;
>  	u32 range[2];
>  
> +	vexpress_sysreg_of_early_init();
> +
>  	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
>  	if (!osc)
>  		return;
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
