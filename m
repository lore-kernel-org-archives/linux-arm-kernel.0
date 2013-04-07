From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 7 Apr 2013 20:21:58 +0100
Subject: [PATCH] regulator: mc13783: Add device tree probe support
In-Reply-To: <1365354131-9770-1-git-send-email-shc_work@mail.ru>
References: <1365354131-9770-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130407192157.GQ6597@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 09:02:11PM +0400, Alexander Shiyan wrote:
> Patch adds device tree probe support for mc13783-regulator driver.

I'd expect to see a document describing the binding for any new binding.

> +	if (num_parsed != num_regulators) {
> +		dev_warn(&pdev->dev,
> +		"parsed %d != regulators %d - check your device tree!\n",
> +			num_parsed, num_regulators);
>  
> -		init_data = &pdata->regulators[i];
> -		desc = &mc13783_regulators[init_data->id].desc;
> +		num_regulators = num_parsed;
> +		priv->num_regulators = num_regulators;

Why is this something we warn about?  Users should be able to omit
unused regulators, no point in adding nodes that don't have any real
information.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130407/e27f66d2/attachment.sig>
