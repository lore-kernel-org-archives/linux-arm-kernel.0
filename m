From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Mon, 9 Dec 2013 11:21:22 +0000
Subject: [PATCH 04/10] net: stmmac: sunxi platfrom extensions for GMAC
 in Allwinner A20 SoC's
In-Reply-To: <1386350983-13281-5-git-send-email-wens@csie.org>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-5-git-send-email-wens@csie.org>
Message-ID: <52A5A7B2.4000509@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/13 17:29, Chen-Yu Tsai wrote:
> +static int sun7i_gmac_init(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *addr = NULL;
> +	struct plat_stmmacenet_data *plat_dat = NULL;
> +	u32 priv_clk_reg;
> +
> +	plat_dat = dev_get_platdata(&pdev->dev);
> +	if (!plat_dat)
> +		return -EINVAL;
dev_get_platdata will return NULL for DT, So this function will fail all
the time.

How is it supposed to work?
Am I missing some thing?

--srini
> +
> +	/* Get GMAC clock register in CCU */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	addr = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(addr))
