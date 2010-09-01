From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Sep 2010 10:12:33 +0100
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20100901091233.GK8142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 01:16:42PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> factorise some generic infrastructure to assist looking up struct clks
> for the ARM & SH architecture.
> +/*
> + * Returns a clock. Note that we first try to use device id on the bus
> + * and clock name. If this fails, we try to use clock name only.
> + */
>  struct clk *clk_get(struct device *dev, const char *con_id)
>  {
>  	const char *dev_id = dev ? dev_name(dev) : NULL;
>  
>  	return clk_get_sys(dev_id, con_id);
>  }
> -EXPORT_SYMBOL(clk_get);
> +EXPORT_SYMBOL_GPL(clk_get);
>  
>  void clk_put(struct clk *clk)
>  {
>  	__clk_put(clk);
>  }
> -EXPORT_SYMBOL(clk_put);
> +EXPORT_SYMBOL_GPL(clk_put);

Please leave these as-is.
