From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 11:05:31 +0000
Subject: [PATCH] regulator: core: Make regulator object reflect
 configured voltage
In-Reply-To: <1391493268-3242-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1391493268-3242-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140204110531.GR22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 09:54:28PM -0800, Bjorn Andersson wrote:

> +	/*
> +	 * Make the regulator reflect the configured voltage selected in
> +	 * machine_constraints_voltage()
> +	 */
> +	if (rdev->constraints->apply_uV &&
> +	    rdev->constraints->min_uV == rdev->constraints->max_uV) {
> +		regulator->min_uV = rdev->constraints->min_uV;
> +		regulator->max_uV = rdev->constraints->min_uV;
> +	}
> +

Why not do this at the time we apply the voltage?  That would seem to be
more robust, doing it in a separate place means that we might update one
bit of code and not the other or might change the execution path so that
one gets run and the other doesn't.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/539dcbfa/attachment.sig>
