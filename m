From: davem@davemloft.net (David Miller)
Date: Fri, 06 Dec 2013 16:26:06 -0500 (EST)
Subject: [PATCH 02/10] net: stmmac: Honor DT parameter to force DMA
 store and forward mode
In-Reply-To: <1386350983-13281-3-git-send-email-wens@csie.org>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-3-git-send-email-wens@csie.org>
Message-ID: <20131206.162606.2277176361893801778.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>
Date: Sat,  7 Dec 2013 01:29:35 +0800

> @@ -47,6 +47,7 @@ static int stmmac_probe_config_dt(struct platform_device *pdev,
>  		plat->bus_id = 0;
>  
>  	of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr);
> +	plat->force_sf_dma_mode = of_property_read_bool(np, "snps,force_sf_dma_mode");

Will this do the right thing for when the property is not present?
Right now the force_sf_dma_mode value is always false.

In fact won't it override the explicit settings done elsewhere in the
driver?
