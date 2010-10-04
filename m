From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Oct 2010 11:30:42 -0700
Subject: [PATCH 3/10] ARM: S5PC100: Add SCLK_SPDIF clock
In-Reply-To: <1286192545-18327-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286192545-18327-1-git-send-email-sw.youn@samsung.com>
Message-ID: <20101004183041.GD2835@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 08:42:25PM +0900, Seungwhan Youn wrote:
> This patch add SCLK_SPDIF clock to support source clock of S/PDIF
> on S5PC100.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but...

> +static int s5pc100_spdif_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	struct clk *pclk;
> +	int ret;

This and the get() look like they're generic (they just proxy the
operation on to the parent clock, which I imagine applies to a bunch of
other clocks too.
