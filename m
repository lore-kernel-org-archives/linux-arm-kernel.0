From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 May 2015 15:17:33 -0700
Subject: [PATCHv4 2/2] clk: socfpga: add a clock driver for the Arria 10
 platform
In-Reply-To: <1432092162-8889-3-git-send-email-dinguyen@opensource.altera.com>
References: <1432092162-8889-1-git-send-email-dinguyen@opensource.altera.com>
 <1432092162-8889-3-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20150521221733.GB1885@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19, dinguyen at opensource.altera.com wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> The clocks on the Arria 10 platform is a bit different than the Cyclone/Arria 5
> platform that it should just have it's own driver.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---

Applied to clk-next. One note below.

> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	init.name = clk_name;
> +	init.ops = ops;
> +	init.flags = 0;
> +	while (i < SOCFPGA_MAX_PARENTS && (parent_name[i] =
> +			of_clk_get_parent_name(node, i)) != NULL)
> +		i++;

Perhaps this should be a generic clk framework helper.
	
	int of_clk_parent_something(node, array, size)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
