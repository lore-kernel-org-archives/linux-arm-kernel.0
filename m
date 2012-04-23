From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Apr 2012 17:43:51 +0300
Subject: [PATCH v2] arm: omap4: hsmmc: check for null pointer
In-Reply-To: <1335192067-3666-1-git-send-email-balajitk@ti.com>
References: <1335192067-3666-1-git-send-email-balajitk@ti.com>
Message-ID: <20120423144348.GF26302@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 23, 2012 at 08:11:07PM +0530, Balaji T K wrote:
> +int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
> +{
> +	struct omap2_hsmmc_info *c;
> +
> +	omap_hsmmc_init(controllers);
> +	for (c = controllers; c->mmc; c++) {
> +		/* pdev can be null if CONFIG_MMC_OMAP_HS is not set */
> +		if (!c->pdev)
> +			continue;
> +		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
> +	}
> +
> +	return 0;
> +}

why are you even calling this if CONFIG_MMC_OMAP_HS isn't set ? Just
stub it out if you don't have mmc support.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120423/78dc7f51/attachment.sig>
