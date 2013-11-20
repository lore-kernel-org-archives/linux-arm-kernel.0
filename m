From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Nov 2013 15:35:07 +0000
Subject: [PATCH v2 4/5] regulator: max14577: Add regulator driver for
 Maxim 14577
In-Reply-To: <1384956732-19526-5-git-send-email-k.kozlowski@samsung.com>
References: <1384956732-19526-1-git-send-email-k.kozlowski@samsung.com>
 <1384956732-19526-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131120153507.GH2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 03:12:11PM +0100, Krzysztof Kozlowski wrote:

> +	size = sizeof(struct regulator_dev *) * pdata->num_regulators;
> +	info->regulators = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +	if (!info->regulators) {
> +		dev_err(&pdev->dev, "Cannot allocate memory for regulators\n");
> +		return -ENOMEM;
> +	}

The set of regulators in the silicon doesn't vary - you should
unconditionally register all the regulators.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/2956c353/attachment-0001.sig>
