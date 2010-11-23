From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Nov 2010 18:38:33 +0000
Subject: [PATCH 2/3] regulators: Update of ab8500 driver
In-Reply-To: <1290536754-21775-3-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1290536754-21775-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1290536754-21775-3-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <20101123183833.GB19212@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 07:25:53PM +0100, Bengt Jonsson wrote:
> This patch updates the driver with some bug fixes, support
> for v2 hardware, support for regulator_count_voltages,
> changes for reading the board config, added indexing of
> the regulator array and added debug prints.

This is a whole series of changes which don't seem terribly related to
each other and aren't clearly described - please split this out into a
patch series which clearly shows each individual change.  For example,
one change per bug fix, another adding v2 support, another adding count
support and so on.  As things stand it's very difficult to review your
patch as it's not clear what each change is supposed to be doing or that
bits haven't been missed from changes.

> -	ret = abx500_get_register_interruptible(info->dev, info->voltage_bank,
> -		info->voltage_reg, &value);
> +	ret = abx500_get_register_interruptible(info->dev,
> +			info->voltage_bank, info->voltage_reg, &regval);

In addition to what's noted above you also appear to have some renaming
of variables and struct members plus some other stylistic changes which
adds to the noise, again these should be split out for ease of review.

> +	[AB8500_REGULATOR_INTCORE] = {
> +		.desc = {
> +			.name		= "intcore",

The previous way of listing the regulators with a macro seemed more
immediately readable?
