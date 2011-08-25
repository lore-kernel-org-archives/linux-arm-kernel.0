From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 25 Aug 2011 12:12:54 +0100
Subject: [PATCH 06/11] clk: Provide a dummy clk_unregister()
In-Reply-To: <1314191759-16941-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1314191759-16941-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20110825111254.GD2838@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Aug 24, 2011 at 02:15:54PM +0100, Mark Brown wrote:
> Even though unregistration is not actually supported by the clk API it is
> still useful to provide a clk_unregister() so that drivers can implement
> their unregistration code. This saves having to go back later and update
> them once unregistration is possible.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/linux/clk.h |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 2ca4f66..df5c64f 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -149,6 +149,21 @@ extern struct clk_hw_ops clk_gate_ops;
>  struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
>  			 const char *name);
>  
> +/**
> + * clk_unregister - remove a clock
> + *
> + * @clk: clock to unregister
> + *
> + * Remove a clock from the clk subsystem.  This is currently not
> + * implemented but is provided to allow unregistration code to be
> + * written in drivers ready for use when an implementation is
> + * provided.
> + */
> +static inline int clk_unregister(struct clk *clk)
> +{
> +	return -ENOTSUPP;
> +}

ENOTSUPP is only defined in include/linux/errno.h which isn't included 
here.  I think either linux/errno.h needs to be included or use 
EOPNOTSUPP?

Jamie
