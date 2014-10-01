From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Oct 2014 19:13:46 +0100
Subject: [RFC 7/7] regulator: qcom-smd-rpm: Regulator driver for the
 Qualcomm RPM
In-Reply-To: <1412037291-16880-8-git-send-email-bjorn.andersson@sonymobile.com>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-8-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20141001181346.GI4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 05:34:51PM -0700, Bjorn Andersson wrote:

> According to the datasheet for the PMIC the regulators are indeed programmed in
> steps, but the steps seems to vary between different regulators and the details
> are hidden by the RPM that exposes contiguous voltage ranges.

> Either we run with this, add a few more compatibles to encode the steps or have
> the step coming from devicetree. I prefer the current implementation as that is
> the cleanest of these.

We have support for this sort of regulator in the core anyway so just
keep on doing what you're doing.

> +	if (vreg->desc.ops->set_voltage &&
> +	    (!initdata->constraints.min_uV || !initdata->constraints.max_uV)) {
> +		dev_err(&pdev->dev, "no voltage specified for regulator\n");
> +		return -EINVAL;
> +	}

You shouldn't need to do this - it should be perfectly legal to have the
ability to set voltages but not use that ability.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/1b474f99/attachment.sig>
