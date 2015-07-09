From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jul 2015 19:35:08 +0100
Subject: [PATCH 1/3] regulator: 88pm800: Add 88pm860 regulator support
In-Reply-To: <1436445692-10656-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436445692-10656-2-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150709183508.GN11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 06:11:30PM +0530, Vaibhav Hiremath wrote:

> +/* dummy table */
> +static const struct regulator_linear_range buck_volt_range_dummy[] = {
> +};

I don't understand this, it certainly doesn't look very healthy and
would need more documentation.

> +/* dummy table */
> +static const unsigned int ldo_volt_table_dummy[] = {
> +};

Likewise.

> -	ret = of_regulator_match(&pdev->dev, np,
> -				 pm800_regulator_matches,
> -				 ARRAY_SIZE(pm800_regulator_matches));
> -	if (ret < 0)
> +	ret = of_regulator_match(&pdev->dev, np, *regulator_matches, range);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Error parsing regulator init data: %d\n", ret);
>  		return ret;
> +	}

Can you convert the driver to use the more modern core matching code
(setting of_match in the driver struct)?  That should simplify this
change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/56e6bc33/attachment.sig>
