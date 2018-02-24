From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 11:54:05 +0800
Subject: [PATCH v2 4/4] clk: imx: add clock driver for i.MX8MQ CCM
In-Reply-To: <20180201175412.9480-4-l.stach@pengutronix.de>
References: <20180201175412.9480-1-l.stach@pengutronix.de>
 <20180201175412.9480-4-l.stach@pengutronix.de>
Message-ID: <20180224035404.GZ3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 06:54:12PM +0100, Lucas Stach wrote:
> +	for (i = 0; i < IMX8MQ_CLK_END; i++)
> +		if (IS_ERR(clks[i]))
> +			pr_err("i.MX8mq clk %u register failed with %ld\n",
> +			       i, PTR_ERR(clks[i]));

We have a helper imx_check_clocks() for this.

Shawn
