From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 18:13:32 +0100
Subject: [PATCH 1/4] S3C2443: Move i2s clock definitions to common code
In-Reply-To: <201108201801.29541.heiko@sntech.de>
References: <201108201757.56483.heiko@sntech.de>
	<201108201801.29541.heiko@sntech.de>
Message-ID: <20110821171332.GF28546@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 20, 2011 at 06:01:29PM +0200, Heiko St?bner wrote:
> +/* i2s-ref
> + *
> + * i2s bus reference clock, selectable from external, esysclk or epllref
> + *
> + * Note, this used to be two clocks, but was compressed into one.
> +*/
> +
> +struct clk *clk_i2s_srclist[] = {
> +	[0] = &clk_i2s_eplldiv.clk,
> +	[1] = &clk_i2s_ext,
> +	[2] = &clk_epllref.clk,
> +	[3] = &clk_epllref.clk,
> +};

Is there any reason not to make this static (have you run your patch
through checkpatch.pl ?)
