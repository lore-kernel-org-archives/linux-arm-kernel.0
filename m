From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 Jul 2016 22:12:35 +0100
Subject: [PATCH V8 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1468240179-7558-2-git-send-email-john@phrozen.org>
References: <1468240179-7558-1-git-send-email-john@phrozen.org>
 <1468240179-7558-2-git-send-email-john@phrozen.org>
Message-ID: <20160711211235.GB9976@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 02:29:39PM +0200, John Crispin wrote:

> +static const struct of_device_id mt6323_of_match[] = {
> +	{ .compatible = "mediatek,mt6323-regulator", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, mt6323_of_match);

This may have been answered last time but I don't remember - why is
there a compatible string for this device in the DT?  Surely we already
know that the regulators for the mt6323 are present by virtue of the
fact that we know that the core mt6323 is present in the system?
Indeed, looking at the now merged MFD code it appears that this is
in fact the case so we could just not have a compatible and perhaps this
was just an oversight.  This is good because it means we're not encoding
the specific way Linux instantiates devices into the DT.

Otherwise this does look good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160711/d17f5c40/attachment.sig>
