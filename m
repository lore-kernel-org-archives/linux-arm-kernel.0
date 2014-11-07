From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Nov 2014 15:22:01 +0000
Subject: [REPOST PATCH 1/2] ARM: OMAP3+: TWL: add support for mapping
 platform data via pdata-quirks
In-Reply-To: <1412949989-20186-2-git-send-email-t-kristo@ti.com>
References: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
 <1412949989-20186-2-git-send-email-t-kristo@ti.com>
Message-ID: <20141107152201.GS8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 05:06:28PM +0300, Tero Kristo wrote:

> -	dev->platform_data = &twl_gpio_auxdata;
> +	if (!strcmp("twl4030-gpio", dev_name(dev)))
> +		dev->platform_data = &twl_gpio_auxdata;
> +	else
> +		dev->platform_data = omap_twl_match_regulator(dev);

Looking at this idiom here I'd expect that we'd be adding another string
comparison here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141107/de6c774f/attachment.sig>
