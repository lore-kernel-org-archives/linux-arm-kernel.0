From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 4 Sep 2012 19:34:32 +0800
Subject: [PATCH v5 3/4] regulator: anatop-regulator: convert to use
 syscon to access anatop register
In-Reply-To: <1346728811-25788-4-git-send-email-b29396@freescale.com>
References: <1346728811-25788-1-git-send-email-b29396@freescale.com>
 <1346728811-25788-4-git-send-email-b29396@freescale.com>
Message-ID: <20120904113429.GK2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 11:20:10AM +0800, Dong Aisheng wrote:
> +
> +	anatop_np = of_get_parent(np);
> +	if (!anatop_np)
> +		return -ENODEV;
> +	sreg->anatop = syscon_node_to_regmap(anatop_np);
> +	if (IS_ERR(sreg->anatop))
> +		return PTR_ERR(sreg->anatop);
> +
With of_node_put moved out from syscon_node_to_regmap, shouldn't
we put anatop_np here then?

-- 
Regards,
Shawn
