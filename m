From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Oct 2012 12:39:40 -0700
Subject: [RFC 2/7] capebus: Add beaglebone board support
In-Reply-To: <1351702333-8456-3-git-send-email-panto@antoniou-consulting.com>
References: <1351702333-8456-1-git-send-email-panto@antoniou-consulting.com>
 <1351702333-8456-3-git-send-email-panto@antoniou-consulting.com>
Message-ID: <20121030193939.GR11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [121030 12:00]:
> +
> +	priv->lcdc_oh = omap_hwmod_lookup("lcdc");
> +	if (priv->lcdc_oh == NULL) {
> +		dev_err(&pdev->dev, "Failed to lookup omap_hwmod lcdc\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->lcdc_pdev = omap_device_build("da8xx_lcdc", 0, priv->lcdc_oh,
> +			&priv->lcd_pdata,
> +			sizeof(struct da8xx_lcdc_platform_data),
> +			NULL, 0, 0);
> +	if (priv->lcdc_pdev == NULL) {
> +		dev_err(&pdev->dev, "Failed to build LCDC device\n");
> +		return -ENODEV;
> +	}

..and these kind of things need to become private to
arch/arm/mach-omap2, we already have it working for other
devices with device tree.

Regards,

Tony
