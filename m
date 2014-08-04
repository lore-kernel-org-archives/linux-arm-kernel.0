From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 04 Aug 2014 09:49:12 -0700
Subject: [PATCH] clk: Add missing of_clk_set_defaults export
In-Reply-To: <1407149338-18401-1-git-send-email-s.nawrocki@samsung.com>
References: <1407149338-18401-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140804164912.5867.65231@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2014-08-04 03:48:58)
> The of_clk_set_defaults() function is used in subsystems which can
> be built as module. Add the missing symbol export entry so there
> is no build errors like:
> "ERROR: "of_clk_set_defaults" [drivers/i2c/i2c-core.ko] undefined!".
> 
> Fixes commit: 86be408bfbd846fab3c4ac21d6f9298bd2e4b790
> "clk: Support for clock parents and rates assigned from device tree"
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Thanks for the quick fixup. Applied for 3.17.

Regards,
Mike

> ---
>  drivers/clk/clk-conf.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index 4e1bda7..aad4796 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -141,3 +141,4 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
> 
>         return __set_clk_rates(node, clk_supplier);
>  }
> +EXPORT_SYMBOL_GPL(of_clk_set_defaults);
> --
> 1.7.9.5
> 
