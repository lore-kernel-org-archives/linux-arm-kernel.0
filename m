From: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 3 Dec 2009 10:27:00 +0000
Subject: [PATCH 8/8] OMAP1 clock: convert mach-omap1/clock.h to
	mach-omap1/clock_data.c
In-Reply-To: <20091203100707.1203.98247.stgit@localhost.localdomain>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
	<20091203100707.1203.98247.stgit@localhost.localdomain>
Message-ID: <20091203102700.GA30423@flint.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 03:07:08AM -0700, Paul Walmsley wrote:
> -static int clk_omap1_dummy_enable(struct clk *clk)
> +int clk_omap1_dummy_enable(struct clk *clk)
>  {
>  	return 0;
>  }
>  
> -static void clk_omap1_dummy_disable(struct clk *clk)
> +void clk_omap1_dummy_disable(struct clk *clk)
>  {
>  }
>  
> -static const struct clkops clkops_dummy = {
> -	.enable = clk_omap1_dummy_enable,
> -	.disable = clk_omap1_dummy_disable,
> -};

I've no idea why you're moving the clkops into these other files - I think
this is going far too far.  Why not just make the clkops structures non-
static?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
