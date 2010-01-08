From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 08 Jan 2010 12:17:57 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <1262907852.736281.78480196040.1.gpush@pororo>
References: <1262907852.736281.78480196040.1.gpush@pororo>
Message-ID: <1262913477.2173.696.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +int clk_enable(struct clk *clk)
> +{
> +	if (clk->enable)
> +		return clk->enable(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_enable);

 .../...

All those guys look like good candidates to be inlined :-)

Cheers,
Ben.
