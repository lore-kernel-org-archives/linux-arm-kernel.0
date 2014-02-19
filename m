From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Feb 2014 13:52:32 +0900
Subject: [PATCH v2 3/5] regulator: add bcm590xx regulator driver
In-Reply-To: <1392765432-9111-4-git-send-email-mporter@linaro.org>
References: <1392765432-9111-1-git-send-email-mporter@linaro.org>
 <1392765432-9111-4-git-send-email-mporter@linaro.org>
Message-ID: <20140219045232.GD2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 06:17:10PM -0500, Matt Porter wrote:

> +static struct of_device_id bcm590xx_of_match[] = {
> +	{ .compatible = "brcm,bcm59056-regs", },
> +	{ }
> +};

This looks pretty much OK however I am in general suspicious of MFDs
that have subdevices like this in the DT - it doesn't seem like this is
a reusable device which can appear anywhere else so you're pretty much
just representing the way that Linux splits things up here rather than a
reusable IP that can reasonably have a separate binding.

If you had a binding which did something like enumerate the individual
IP blocks as individual devices that'd be more interesting, I could see
for example that a different PMIC might have a different set of register
compatible regulator IPs laid out.  It looks like that might be doable,
but it's in no way essential.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/3104d004/attachment-0001.sig>
