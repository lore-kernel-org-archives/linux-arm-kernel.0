From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Mar 2014 17:33:07 +0000
Subject: [PATCH v2 5/8] regulator: AXP20x: Add support for regulators
 subsystem
In-Reply-To: <1394898225-28452-6-git-send-email-carlo@caione.org>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-6-git-send-email-carlo@caione.org>
Message-ID: <20140317173307.GX11706@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 04:43:42PM +0100, Carlo Caione wrote:
> AXP202 and AXP209 come with two synchronous step-down DC-DCs and five
> LDOs. This patch introduces basic support for those regulators.

This is mostly fine apart from the things Krzysztof mentioned and...

> +static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
> +{
> +	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> +
> +	if (dcdcfreq < 750)
> +		dcdcfreq = 750;
> +
> +	if (dcdcfreq > 1875)
> +		dcdcfreq = 1875;

I'd expect at least a warning on out of spec values being specified
here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/d64f3f99/attachment.sig>
